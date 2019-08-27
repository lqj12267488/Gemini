/**
 * Created by Admin on 2017/5/5.
 */
function getPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0, index + 1);
    return result;
}

function addOption(data, select, selected) {
    $("#" + select).html("");
    if (selected === undefined) {
        $("#" + select).append("<option value='' selected>请选择</option>")
    } else {
        $("#" + select).append("<option value=''>请选择</option>")
    }

    $.each(data, function (index, content) {

        if (content.id === selected) {
            $("#" + select).append("<option value='" + content.id + "' selected>" + content.text + "</option>")
        } else {
            $("#" + select).append("<option value='" + content.id + "'>" + content.text + "</option>")
        }
    })
    if (data.length == 0) {
        $("#" + select).append("<option value=''>无数据</option>")
    }
}

/**
 * 自动补全功能的配置
 * @param el 需要制作成自动补全的元素id
 * @param url 数据源url
 * @param el_val 存放选中的id值元素id
 */
function autoComplateOptions(el, url, el_val, ) {
    $("#"+el).autocomplete({
        source: function (request , response) {
            $.get(url,{
                name: request.term
            },function(data){
                if(data==''){
                    $("#"+el_val).val('');
                }
                response( $.ui.autocomplete.filter(
                    data, request.term ));
            })
        },
        select: function (event, ui) {
            $("#"+el).val(ui.item.label.split("  ----  ")[0]);
            $("#"+el).attr("keycode", ui.item.value);
            $("#"+el_val).val(ui.item.value);
            return false;
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<li>")
            .append("<a>" + item.label + "</a>")
            .appendTo(ul);
    };
}

/**
 * 自动补全功能的配置
 * @param el 需要制作成自动补全的元素id
 * @param url 数据源url
 */
function autoComplateOption(el, url) {
    $("#"+el).autocomplete({
        source: function (request , response) {
            $.get(url,{
                name: request.term
            },function(data){
                if(data==''){
                    $("#"+el).attr('keycode','');
                }
                response( $.ui.autocomplete.filter(
                    data, request.term ));
            })
        },
        select: function (event, ui) {

            $("#"+el).val(ui.item.label.split("  ----  ")[0]);
            $("#"+el).attr("keycode", ui.item.value);
            return false;
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<li>")
            .append("<a>" + item.label + "</a>")
            .appendTo(ul);
    };
}

function addAdministrativeDivisions(provinceId, provinceValue, cityId, cityValue, countyId, countyValue, path) {
    //省籍初始化
    getAdministrativeDivisions(provinceId, provinceValue, " and type = '1' ", path);
    //市籍初始化
    var where = "";
    //区籍初始化
    if (null != provinceValue && provinceValue != "") {
        where = " and parent_id ='" + provinceValue + "'";
        getAdministrativeDivisions(cityId, cityValue, " and type = '2' " + where, path);
    }
    if (null != cityValue && cityValue != "") {
        where = " and parent_id ='" + cityValue + "'";
        getAdministrativeDivisions(countyId, countyValue, " and type = '3' " + where, path);
    }

    liandong(provinceId, cityId, countyId, path);
}

function getAdministrativeDivisions(id, value, where, path) {
    $.get(path + "/common/getTableDict", {
            id: " id",
            text: " name ",
            tableName: " t_sys_administrative_divisions ",
            where: " WHERE valid_flag = '1' " + where,
            orderBy: " order by show_order ",
        },
        function (data) {
            addOption(data, id, value);
        });
}

function liandong(provinceId, cityId, countyId, path) {
    //市籍联动
    $("#" + provinceId).change(function () {
        if ($("#" + provinceId + " option:selected").val() != "") {
            getAdministrativeDivisions(cityId, "", " and type = '2' and parent_id ='" + $("#" + provinceId + " option:selected").val() + "'", path);
        }
    });

    //区籍联动
    $("#" + cityId).change(function () {
        if ($("#" + cityId + " option:selected").val() != "") {
            getAdministrativeDivisions(countyId, "", " and type = '3' and parent_id ='" + $("#" + cityId + " option:selected").val() + "'", path);
        }
    });
}

var listclass =['icon-inbox','icon-qrcode','icon-barcode'];

//  首页 菜单滚动方法
function DY_scroll(wraper,prev,next,img,speed,or)
{
    var wraper = $(wraper);
    var prev = $(prev);
    var next = $(next);
    var img = $(img).find('ul');
    var w = img.find('li').outerWidth(false);
    var s = speed;
    next.click(function()
    {
        img.animate({'margin-left':-w},function()
        {
            img.find('li').eq(0).appendTo(img);
            img.css({'margin-left':0});
            img.find('li:first').stop()
        });
    });
    prev.click(function()
    {
        img.find('li:last').prependTo(img);
        img.css({'margin-left':-w});
        img.animate({'margin-left':0});

    });
    if (or == true)
    {
        ad = setInterval(function() { next.click();},s*1000);
        wraper.hover(function(){clearInterval(ad);},function(){ad = setInterval(function() { next.click();},s*1000);});

    }
}

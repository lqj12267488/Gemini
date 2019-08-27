<%-- Created by IntelliJ IDEA. User: Administrator Date: 2017/5/24 Time: 15:05 To change this template use File | Settings | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css"> textarea {
        resize: none;
    }</style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white" style="width:610px">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">${head}</span></div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar"><span class="iconBtx">*</span>团队名称</div>
                    <div class="col-md-10">
                        <div><input id="planName" type="text" value="${tt.planName}"/></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所属专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorId" onchange="changeMajorCode()" value="${tt.majorId}" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业代码
                    </div>
                    <div class="col-md-4">
                        <input type="text" readonly id="majorCode" value="${tt.majorCode}"/>
                    </div>

                </div>
                <div class="form-row">
                        <div class="col-md-2 tar"><span class="iconBtx">*</span>团队等级</div>
                        <div class="col-md-4">
                            <select id="teamLevelCode" value="${tt.teamLevelCode}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>获批时间
                        </div>
                        <div class="col-md-4">
                            <input type="month" id="getDate" value="${tt.getDate}"/>
                        </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>团队负责人
                    </div>
                    <div class="col-md-10">
                        <input type="text" id="chargePer" onchange="chargePerValChange()" onblur="perOnBlur($(this))" value="${teamTeacher.name}"/>
                        <input id="chargePerId" type="hidden"  value='${teamTeacher.deptId},${teamTeacher.personId}'/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar"><span class="iconBtx">*</span>团队成员</div>
                    <div class="col-md-10">
                        <input placeholder="按在团队内顺序填写教师姓名，用“分号”分隔" type="text" onchange="membersValChange()"
                               onblur="perOnBlur($(this))" id="members" value="${tt.getDate}"/>
                       <%-- <input id="membersId" type="hidden" value="${tt.membersId}"/>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="id" hidden value="${tt.id}"/>
<input id="dept" hidden value="${tt.departmentsId}"/>
<script> $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
//本全局参数存取选择的成员信息为json数组
var optionData=[];
$(document).ready(function () {

    //修改时显示的成员数据初始化
    var members=eval('${members}');
    var str='';
    if(null == '${members}' || "" =='${members}' ){
    }else{
        for(var i=0;i<members.length; i++){
            optionData[optionData.length]={
                'deptId': members[i].deptId+','+members[i].personId,
                'name': members[i].name
            };
            str+=members[i].name+'；';
        }
    }
    $('#members').val(str);
    //当清除成员输入框时对应的optionData也要清掉相应部分的json
    $("#members").change(function (event, data) {
        var namesStr=[];
        if($(this).val().lastIndexOf('；')!=$(this).val().length-1){
            namesStr=$(this).val().split("；");
        }else{
            namesStr=$(this).val().substring(0, $(this).val().length-1).split("；");
        }
        var hasIndexs=[];
        var newData=[];
        for(var i=0; i<namesStr.length; i++){
             for(var j=0; j<optionData.length; j++){

                var obj=optionData[i];
                if(obj.name==namesStr[j]){
                    hasIndexs[hasIndexs.length]=j;
                    break;
                }
            }
        }
        var length1 =optionData.length;
        for(var i=0;i<hasIndexs.length;i++){
            newData[i]=optionData[hasIndexs[i]];
        }
        optionData=newData;
    });

    //专业
    $.get("<%=request.getContextPath()%>/major/getAllMajor", function (data) {
        addMajorOption(data, 'majorId', '${tt.majorId}');
    });

    $.get("<%=request.getContextPath()%>/common/getSysDict?name=TDDJ", function (data) {
        addOption(data, 'teamLevelCode', '${tt.teamLevelCode}');
    });

    //团队负责人自动补全
    $("#chargePer").autocomplete({
        source: function(request, response){
            var name=request.term;
            $.get("<%=request.getContextPath()%>/common/getPersonByName?name="+name,function(data){
                response(data);
            })
        },
        select: function (event, ui) {
            $("#chargePer").val(ui.item.label.split(" ---- ")[0]);
            $("#chargePer").attr("keycode", ui.item.value);
            $("#chargePerId").val(ui.item.value);

            return false;
        }
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<li>")
            .append("<a>" + item.label + "</a>")
            .appendTo(ul);
    };


    //团队成员自动补全
    $("#members")
    // 当选择一个条目时不离开文本域
        .bind( "keydown", function( event ) {
            if ( event.keyCode === $.ui.keyCode.TAB &&
                $( this ).data( "ui-autocomplete" ).menu.active ) {
                event.preventDefault();
            }
        })
        .autocomplete({
            minLength: 0,
            source: function( request, response ) {
                $.get("<%=request.getContextPath()%>/common/getPersonByName?name="+"",function(data){
                    // 回到 autocomplete，但是提取最后的条目
                    response( $.ui.autocomplete.filter(
                        data, extractLast( request.term ) ) );
                })

            },
            focus: function() {
                // 防止在获得焦点时插入值
                return false;
            },
            select: function( event, ui ) {

                var namesStr=[];
                if($("#members").val().lastIndexOf('；')!=$("#members").val().length-1){
                    namesStr=$("#members").val().split("；");
                }else{
                    namesStr=$("#members").val().substring(0, $("#members").val().length-1).split("；");
                }
                var hasIndexs=[];
                var newData=[];
                for(var i=0; i<namesStr.length; i++){
                    for(var j=0; j<optionData.length; j++){

                        var obj=optionData[i];
                        if(obj!=undefined){
                            if(obj.name==namesStr[j]){
                                hasIndexs[hasIndexs.length]=j;
                                break;
                            }
                        }
                    }
                }
                var lengths =optionData.length;
                for(var i=0;i<hasIndexs.length;i++){
                    newData[i]=optionData[hasIndexs[i]];
                }
                optionData=newData;

                var terms = split( this.value );
                // 移除当前输入
                terms.pop();
                // 添加被选项
                terms.push( ui.item.label.split(' ---- ')[0] );
                // 添加占位符
                terms.push( "" );
                optionData[optionData.length]={
                    "deptId": ui.item.value,
                    "name": ui.item.label.split(' ---- ')[0]
                };
                this.value = terms.join( "；" );
                return false;
            }
        });
});

function save() {
    var majorId = $("#majorId option:selected").val();
    var majorCode = majorId.split(",")[0];
    //var majorIdShow=$("#majorId option:selected").text();
    var planName = $("#planName").val();
    var teamLevelCode = $("#teamLevelCode").val();
    if (planName == "" || planName == undefined || planName == null) {
        swal({
            title: "请选择团队名称！",
            type: "info"
        });
        return;
    }
    if (majorId == "" || majorId == undefined || majorId == null) {
        swal({
            title: "请选择专业！",
            type: "info"
        });
        return;
    }

    if (planName == "" || planName == undefined || planName == null) {
        swal({
            title: "请填写专业代码！",
            type: "info"
        });
        return;
    }
    if (teamLevelCode == "" || teamLevelCode == undefined || teamLevelCode == null) {
        swal({
            title: "请选择团队等级！",
            type: "info"
        });
        return;
    }
    if ($("#getDate").val() == "" || $("#getDate").val() == null) {
        swal({
            title: "请选择获批时间",
            type: "info"
        });
        return;
    }
    if ($("#chargePerId").val() == "," || $("#chargePerId").val() == null || $("#chargePerId").val() == "") {
        swal({
            title: "请正确选择团队负责人",
            type: "info"
        });
        return;
    }
    if (optionData.length == 0) {
        swal({
            title: "请正确选择团队成员",
            type: "info"
        });
        return;
    }
    showSaveLoading();
    $.post("<%=request.getContextPath()%>/major/saveTeachingTeam", {
        id:$("#id").val(),
        planName: $('#planName').val(),
        //departmentsId:departmentsId,
        majorId: majorId,
        //majorIdShow: majorIdShow,
        getDate: $("#getDate").val(),
        teamTeacher: $("#chargePerId").val(),
        getDate: $("#getDate").val(),
        teamLevelCode: $("#teamLevelCode").val(),
        teamPerson: function () {
            var data='';
            for(var i=0;i<optionData.length;i++){
                data=data+(optionData[i].deptId+';');
            }
            return data;
        }
    }, function (msg) {
        hideSaveLoading();
        swal({
            title: msg.msg,
            type: msg.status===0?'error':"success"
        });
        if(msg.status===1){
            $("#dialog").modal('hide');
            $("#right").load("<%=request.getContextPath()%>/major/TeachingTeam");
        }

    })
}

//团队成员失去焦点
    function perOnBlur(ele){
        var val=ele.val();
            temp=val.substring(val.length-1, val.length);
            if(temp=='；'){
                ele.val(val.substring(0,val.length-1));
            }
    }



//专业下拉框初始化
function addMajorOption(data, select, selected) {
    $("#" + select).html("");
    if (selected === undefined) {
        $("#" + select).append("<option value='' selected>请选择</option>")
    } else {
        $("#" + select).append("<option value=''>请选择</option>")
    }

    $.each(data, function (index, content) {

        if (content.majorId === selected) {
            $("#" + select).append("<option value='" + content.majorId + "' selected>" + content.majorName + "</option>");
            changeMajorCode();
        } else {
            $("#" + select).append("<option value='" + content.majorId + "'>" + content.majorName + "</option>")
        }
    })
    if (data.length == 0) {
        $("#" + select).append("<option value=''>无数据</option>")
    }
}
function changeMajorCode() {
    var majorId=$("#majorId").val();
    $.post(
        "<%=request.getContextPath()%>/major/getMajorById",
        {
            id:majorId
        },
        function (data) {
            $("#majorCode").val(data.majorCode);
        }
    );
}

function split( val ) {
    return val.split( /；\s*/ );
}
function extractLast( term ) {
    return split( term ).pop();
}

function chargePerValChange() {
    var chargePer=$("#chargePer").val();
    if(chargePer==''){
        $("#chargePerId").val("");
    }
}

function membersValChange() {
    var members=$("#members").val();
    if(members==''){
        optionData=[];
    }
}

</script>




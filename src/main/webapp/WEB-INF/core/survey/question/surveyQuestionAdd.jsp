<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        序号
                    </div>
                    <div class="col-md-9">
                        <input id="questionOrder" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        问题
                    </div>
                    <div class="col-md-9">
                        <input id="questionName"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        答题方式
                    </div>
                    <div class="col-md-9">
                        <select id="questionType" onchange="qTypeFun()" ></select>
                    </div>
                </div>
                <div class="form-row" id="questionTypeRow" style="display: none">
                    <div class="col-md-3 tar">
                        <button class="btn btn-default btn-clean" onclick="addCheck()"  id="check">新增选项</button>
                    </div>
                    <div class="col-md-9"  id="checkShow">
                    </div>
                </div>
                <div class="form-row" id="questionTypeTree" style="display: none">
                    <div class="col-md-3 tar">
                        选择教师
                    </div>
                    <div class="col-md-9" >
                        <div class="controls" id="style-4" style="overflow-y:auto;height:200px ">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
   var surveyType = $("#surveyType").val();
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DTFS", function (data) {
            addOption(data, 'questionType');
           /* $("#" + 'questionType').append("<option value=''>请选择</option>");
            $.each(data, function (index, content) {
                if(surveyType =='1'){
                    if(content.id != '1')
                        $("#" + 'questionType').append("<option value='" + content.id + "'>" + content.text + "</option>")
                }else if(surveyType =='2'){
                    if(content.id != '4' && content.id != '5' )
                        $("#" + 'questionType').append("<option value='" + content.id + "'>" + content.text + "</option>")
                }
            })*/
        });
    });


    function save() {
        var surveyId = $("#surveyId").val();
        var questionName = $("#questionName").val();
        var questionType = $("#questionType").val();
        var questionOrder = $("#questionOrder").val();
        var remark = $("#remark").val();
        if (questionOrder == "" || questionOrder == undefined || questionOrder == null) {
            swal({
                title: "请填写问题序号！",
                type: "info"
            });
            return;
        }
        if (questionName == "" || questionName == undefined || questionName == null) {
            swal({
                title: "请填写问题！",
                type: "info"
            });
            return;
        }
        if (questionType == "" || questionType == undefined || questionType == null) {
            swal({
                title: "请填写答题方式！",
                type: "info"
            });
            return;
        }

        var checkval ="";
        if(  $("#questionType").val()=='4' || $("#questionType").val() == '5' ){
            var nodes = EmpDeptTree.getCheckedNodes(true);
            var id = '';
            for (var i = 0; i < nodes.length; i++) {
                var item = nodes[i].id;
                if(item.indexOf(",") != -1)
                    id+= item +"##";
            }
            if(id!=''){
                id = id.substring(0,id.length-2);
                checkval = id;
            } else{
                swal({title: "请选择教师选项！"});
                return;
            }
        }else if( $("#questionType").val()=='2' || $("#questionType").val() == '3' ){
            var b = false;
            $(".inputBox").each(function(index,item) {
                var val = $(this).attr("id");
                var person =$("#"+ val).val();
                if( person== undefined|| person == "" ){
                    b = true;
                }
                if(index != 0)
                    checkval += "##";
                checkval += person ;
            });
            if(b || checkval ==""){
                swal({title: "请填写答案选项！"});
                return;
            }
        }

        $.post("<%=request.getContextPath()%>/survey/question/saveSurveyQuestion", {
            surveyId:surveyId,
            questionName:questionName,
            questionType:questionType,
            questionOrder:questionOrder,
            remark:remark,
            checkval: checkval,
            surveyType: surveyType,
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#questiontable').DataTable().ajax.reload();
            });
        })
    }

    function guid() {
        function S4() {
            return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
        }
        return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
    }

    function qTypeFun() {
        if ($("#questionType").val() == "1") {
            $("#questionTypeRow").css("display", "none");
            $("#checkShow").html("");
        } else if( $("#questionType").val()=='4' || $("#questionType").val() == '5' ){
            $("#questionTypeTree").css("display", "block");
            $("#questionTypeRow").css("display", "none");
            EmpDeptTree = $.fn.zTree.init($("#treeDemo"), setting, dataEmpDept);
            EmpDeptTree.expandAll(true);

        }else if( $("#questionType").val()=='2' || $("#questionType").val() == '3' ){
            $("#questionTypeRow").css("display", "block");
            $("#questionTypeTree").css("display", "none");
        }
    }
    function addCheck() {
        var id = guid();
        if( $("#questionType").val()=='4' || $("#questionType").val() == '5' ){
            /*
                        var a = '<div class="form-row" id="'+id+'">' +
                            '<div class="col-md-3">可选教师:</div>' +
                            '<div class="col-md-6"><input type="text" id="'+id+'_val" class="inputBox"></div>' +
                            '<div class="col-md-3"><a href="#" onclick="delRow(\''+id+'\')" >删除此选项</a> </div>' +
                            '</div>';
                        $("#checkShow").append(a);

                        $("#"+id+"_val").autocomplete({
                            source: personDate,
                            select: function (event, ui) {
                                $("#"+id+"_val").val(ui.item.label);
                                $("#"+id+"_val").attr("keycode", ui.item.value);
                                return false;
                            }
                        }).data("ui-autocomplete")._renderItem = function (ul, item) {
                            return $("<li>")
                                .append("<a>" + item.label + "</a>")
                                .appendTo(ul);
                        };
            */
        }else if( $("#questionType").val()=='2' || $("#questionType").val() == '3' ){
            var a = '<div class="form-row" id="'+id+'">' +
                '<div class="col-md-3">可选答案:</div>' +
                '<div class="col-md-6"><input type="text" id="'+id+'_val" class="inputBox"></div>' +
                '<div class="col-md-3"><a href="#" onclick="delRow(\''+id+'\')" >删除此选项</a> </div>' +
                '</div>';
            $("#checkShow").append(a);
        }
    }

    function delRow(id){
        var father = document.getElementById("checkShow");
        var child = document.getElementById(id);
        father.removeChild(child);
    }

    var EmpDeptTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "ps", "N": "ps" }
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };


</script>
<style>
    #style-4::-webkit-scrollbar-track
    {
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar
    {
        width: 5px;
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar-thumb
    {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>
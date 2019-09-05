<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title"><div id="head"></div></h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="style-4" style="overflow-y:auto;height:70% ">
                <input id="surveyId" hidden value="${surveyId}">
                <input id="checkFlag" hidden value="${checkFlag}">
                <ul id="surveyPersonTree" class="ztree"></ul>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBut" class="btn btn-success btn-clean" onclick="saveRelation()">保存</button>
            <button class="btn btn-default btn-clean" id="close" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
<script>
    var surveyPersonTree;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/survey/person/getSurveyStudentTree?surveyId="+$("#surveyId").val(), function (data) {
            surveyPersonTree = $.fn.zTree.init($("#surveyPersonTree"), setting, data);
            surveyPersonTree.expandAll(true);
        });
        if($("#checkFlag").val()=="1"){
            $("#saveBut").css("display","none");
            $("#head").html("查看答题学生");
        }else{
            $("#head").html("选择答题学生");
        }
    })

    function saveRelation(){
        var surveyId = $("#surveyId").val();
        var nodes=surveyPersonTree.getCheckedNodes(true);
        var checkList="";
        for(var i=0;i<nodes.length;i++){
            if(nodes[i].level == 4){
                checkList += nodes[i].id+"@";
            }
        }
        if(checkList.length>0)
            checkList = checkList.substring(0,checkList.length-1);
        $.post("<%=request.getContextPath()%>/survey/person/saveSurveyParent", {
            surveyId:surveyId,
            checkList:checkList,
            personType:2
        }, function (msg) {
            if (msg.status == 1 ) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
            }
        })
    }

    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "s", "N": "ps" }
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
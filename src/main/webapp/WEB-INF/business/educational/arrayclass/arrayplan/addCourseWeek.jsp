<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${arrayClassCourseWeek.id}">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学周类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_weekType" class="js-example-basic-single" onchange="changeWeekNumber()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开始学周（包括）
                    </div>
                    <div class="col-md-9">
                        <input id="a_startWeek" value="${arrayClassCourseWeek.startWeek}" onchange="changeWeekNumber()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        结束学周（包括）
                    </div>
                    <div class="col-md-9">
                        <input id="a_endWeek" value="${arrayClassCourseWeek.endWeek}" onchange="changeWeekNumber()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学周数
                    </div>
                    <div class="col-md-9">
                        <input id="a_weekNumber" disabled value="${arrayClassCourseWeek.weekNumber}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        每周学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_weekHours" value="${arrayClassCourseWeek.weekHours}" onchange="changeTotleHours()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        总学时数
                    </div>
                    <div class="col-md-9">
                        <input id="a_totleHours" disabled value="${arrayClassCourseWeek.totleHours}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        上课类型
                    </div>
                    <div class="col-md-9">
                        <select id="a_teachType" class="js-example-basic-single" onchange="changeOtherProperty()"></select>
                    </div>
                </div>
                <div class="form-row" id = "roomType">
                    <div class="col-md-3 tar">
                        教室名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="roomShow" type="text" onclick="showMenu()"  value="${arrayClassCourseWeek.roomShow}"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="classTree" class="ztree"></ul>
                        </div>
                        <input id="classRoom" type="hidden" value="${arrayClassCourseWeek.roomId}"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#roomType").hide();
        if ('${arrayClassCourseWeek.teachType}' =='1' || '${arrayClassCourseWeek.teachType}' == ''){
            $("#roomType").hide();
        }else{
            $("#roomType").show();
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XZLX", function (data) {
            addOption(data, 'a_weekType', '${arrayClassCourseWeek.weekType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SKXS", function (data) {
            addOption(data, 'a_teachType', '${arrayClassCourseWeek.teachType}');
        });
    })
    function changeOtherProperty(){
        var teachType= $("#a_teachType").val();
        if("1"==teachType){
            $("#roomType").hide();
        }else{
            $("#roomType").show();
            $.get("<%=request.getContextPath()%>/common/getTableToTree",{
                    id: " id",
                    text: " class_room_name ",
                    tableName: "T_JW_CLASSROOM ",
                    where: " WHERE VALID_FLAG = 1 and ROOM_TYPE = '"+$("#a_teachType").val()+"'"
                },
                function (data) {
                    zTree = $.fn.zTree.init($("#classTree"), setting, data);
                    var node;
                });
        }



    }
    var weekNumber = 0;
    var totleHours = 0;
    var number = 0;
    var weekType = "";
    function clearWeekNumber(){
        $("#a_weekNumber").val("");
    }
    function changeWeekNumber() {
        weekNumber = (Number($("#a_endWeek").val())-Number($("#a_startWeek").val()))+1;
        weekType = $("#a_weekType option:selected").val();
        if ($("#a_endWeek").val() == "" || $("#a_startWeek").val() == ""){
            number = "";
        }else {
            if (weekType == '1'){
                if((weekNumber%2)!=0){
                    if ($("#a_startWeek").val()%2!=0){
                        number = Math.ceil(weekNumber/2);
                    }else {
                        number = Math.floor(weekNumber/2);
                    }
                }else {
                    number = weekNumber/2;
                }
            }else if (weekType == '2'){
                if((weekNumber%2)!=0){
                    if ($("#a_startWeek").val()%2!=0){
                        number = Math.floor(weekNumber/2);
                    }else {
                        number = Math.ceil(weekNumber/2);
                    }
                }else {
                    number = weekNumber/2;
                }
            }else {
                number = weekNumber;
            }
        }
        $("#a_weekNumber").val(""+number+"");
        changeTotleHours();
    }
    function changeTotleHours() {
        totleHours = weekNumber * $("#a_weekHours").val();
        $("#a_totleHours").val(""+totleHours+"");
    }

    function save() {
        if ($("#a_weekType option:selected").val() == "" || $("#a_weekType option:selected").val() == undefined || $("#a_weekType option:selected").val() == null) {
            swal({
                title: "请选择学周类型！",
                type: "info"
            });
            return;
        }
        if ($("#a_startWeek").val() == "" || $("#a_startWeek").val() == undefined || $("#a_startWeek").val() == null) {
            swal({
                title: "请填写开始学周！",
                type: "info"
            });
            return;
        }
        if ($("#a_endWeek").val() == "" || $("#a_endWeek").val() == undefined || $("#a_endWeek").val() == null) {
            swal({
                title: "请填写结束学周！",
                type: "info"
            });
            return;
        }
        if ($("#a_weekHours").val() == "" || $("#a_weekHours").val() == undefined || $("#a_weekHours").val() == null) {
            swal({
                title: "请填写每周学时数！",
                type: "info"
            });
            return;
        }
        if ($("#a_teachType option:selected").val() == "" || $("#a_teachType option:selected").val() == undefined || $("#a_teachType option:selected").val() == null) {
            swal({
                title: "请选择上课类型！",
                type: "info"
            });
            return;
            if($("#a_teachType option:selected").val() != "0"){
                if ($("#classRoom").val() == "" || $("#classRoom").val() == undefined || $("#classRoom").val() == null) {
                    swal({
                        title: "请选择教室！",
                        type: "info"
                    });
                    return;
                }
            }
        }
        $.post("<%=request.getContextPath()%>/arrayClassCourse/saveArrayClassCourseWeek", {
            arrayClassId: '${arrayClassId}',
            courseType: '${courseType}',
            arrayClassCourseId: '${arrayClassCourseId}',
            departmentsId: '${departmentsId}',
            majorCode: '${majorCode}',
            courseID: '${courseID}',
            credit: '${credit}',
            id: $("#id").val(),
            weekType: $("#a_weekType option:selected").val(),
            startWeek: $("#a_startWeek").val(),
            endWeek: $("#a_endWeek").val(),
            weekNumber: weekNumber,
            weekHours: $("#a_weekHours").val(),
            totleHours: totleHours,
            teachType: $("#a_teachType option:selected").val(),
            roomId : $("#classRoom").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#arrayClassCourseWeekGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<script>
    var zTree;
    var setting = {
        check: {
            enable: true,
            chkboxType: {"Y":"", "N":""}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck
        }
    };

    function beforeClick(treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("classTree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        zTree = $.fn.zTree.getZTreeObj("classTree"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            v += nodes[i].id + ",";
        }

        if (v.length > 0 ) v = v.substring(0, v.length-1);
        var roomVal = $("#classRoom");
        roomVal.attr("value", v);
    }

    function showMenu () {
        var roomObj = $("#classRoom");
        var roomOffset = $("#classRoom").offset();
        $("#menuContent").css({left:roomOffset.left + "px", top:roomOffset.top + roomObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "roomShow" || $(event.target).parents("#menuContent").length>0)) {
            hideTree();
            zTree = $.fn.zTree.getZTreeObj("classTree"),
                nodes = zTree.getCheckedNodes(true);
            $("#classRoom").val(getChildNodes(nodes));//获取子节点
            $("#roomShow").val(getChildNodesSel(nodes));//获取子节点
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].name;
        }
        return nodes.join(",");
    }

    function hideTree() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function getChildNodes(treeNode) {
        var nodes = new Array();
        for(i = 0; i < treeNode.length; i++) {
            nodes[i] = treeNode[i].id;
        }
        return nodes.join(",");
    }


</script>
<style>
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
<style>
    select:disabled {
        background-color: #2c5c82;
        color: #dddddd;
    }
</style>



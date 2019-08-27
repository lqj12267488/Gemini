<%--
  Created by IntelliJ IDEA.
  User: go
  Date: 2019/6/19
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学院：
                            </div>
                            <div class="col-md-2">
                                <input id="majorSchoolSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <input id="majorSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <input id="deptSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="courseSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="peopleSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="applicantDateSel" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                状态：
                            </div>
                            <div class="col-md-2">
                                <select id="statusType" ></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-6">
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">申请</button>
                        </div>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="rescheduleGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<input id="requester" value="${requester}" hidden>
<input id="requesterDept" value="${requesterDept}" hidden>
<input id="tTKSPId"  value="${tTKSPId}" hidden>

<script>
    var requester = $("#requester").val();
    var requesterDept = $("#requesterDept").val();
    var tTKSPId = $("#tTKSPId").val();
    var rescheduleTable;
    $(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TTKZT", function (data) {
            addOption(data,'statusType');
        });
        //初始化下拉菜单信息
         rescheduleTable = $("#rescheduleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rescheduleCourse/getRescheduleCourseList',
                "data": {
                    majorSchoolShow: $("#majorSchoolSel").val(),
                    deptId:$("#deptSel").val(),
                    majorShow:$("#majorSel").val(),
                    courseId:$("#courseSel").val(),
                    classId:$("#classSel").val(),
                    applicantPersonId:$("#peopleSel").val(),
                    applicantDate:$("#applicantDateSel").val(),
                    status:$("#statusType").val(),
                    tTKSPId:$("#tTKSPId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "creator", "visible": false},
                {"data": "createDept", "visible": false},
                {"data": "overruleStatus", "visible": false},
                {"width": "11%","data": "majorSchool", "title": "学院"},
                {"width": "11%","data": "majorCode", "title": "专业"},
                {"width": "11%","data": "deptId", "title": "系部"},
                {"width": "11%","data": "classId", "title": "班级"},
                {"width": "11%","data": "courseId", "title": "课程"},
                {"width": "11%","data": "applicantPersonId", "title": "申请人"},
                {"width": "11%","data": "applicantDate", "title": "申请日期"},
                {"width": "11%","data": "status", "title": "状态"},
                {"width": "12%","data": "approveReason", "title": "驳回原因"},
                {"width": "11%", "title": "操作", "render": function () {return "<a id='updReschedule' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delReschedule' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='submit' class='icon-upload-alt' title='提交'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='approve' class='icon-file-text-alt' title='办理'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        $("#rescheduleGrid").on('click', 'tr a', function () {
            var data =  $("#rescheduleGrid").DataTable().row($(this).parent()).data();
            var id = data.id;
            var creator = data.creator;
            var status = data.status;
            var createDept = data.createDept;
            var overruleStatus = data.overruleStatus;
            if (this.id == "updReschedule") {
                if (creator == requester ) {
                    if (status == "待提交" || overruleStatus == '1' || overruleStatus == '3') {
                        $("#dialog").load("<%=request.getContextPath()%>/rescheduleCourse/updReschedule?id=" + id);
                        $("#dialog").modal("show");
                    }else {
                        swal({
                            title:"申请已提交，无法修改",
                            type:"warning"
                        })
                    }
                }else {
                    swal({
                        title:"无法修改",
                        text:"只有申请人可修改",
                        type:"warning"
                    })
                }
            }
            if (this.id == "submit") {
                if (creator == requester) {
                    if (status == "待提交" || overruleStatus == '1' || overruleStatus == '3'){
                        swal({
                            title: "请确认提交?",
                            text: "提交后无法修改！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确认",
                            closeOnConfirm: false
                        }, function () {
                            $.post("<%=request.getContextPath()%>/rescheduleCourse/updRCWithSubmit", {
                                id: id,
                                tTKSPId:tTKSPId
                            }, function (msg) {
                                swal({title: msg.msg, type: msg.result});
                                $("#dialog").modal('hide');
                                rescheduleTable.ajax.reload();
                            });
                        })
                    } else {
                        swal({
                            title:"申请已提交过！",
                            type:"warning"
                        })
                    }
                }else {
                    swal({
                        title:"无法提交！",
                        text:"只有申请人能提交",
                        type:"warning"
                    })
                }
            }

            // 只有申请人，待提交时才可以删除
            if (this.id == "delReschedule") {
                if (creator == requester && status == "待提交"){
                    swal({
                        title: "请确认是否要删除本条记录?",
                        text: "删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/rescheduleCourse/delRescheduleCourse", {
                            id: id
                        }, function (msg) {
                            swal({title: msg.msg,type: msg.result});
                            $("#dialog").modal('hide');
                            search();
                        });
                    })
                }else {
                    swal({
                        title:"无法删除",
                        type:"warning"
                    })
                }
            }

            //此处改为审批人
            if (this.id == "approve"){
                if ((createDept == requesterDept && (status == "系部待审批" && '${isDeptBoss}'=="1" || (status == "已审批" && overruleStatus == '2' && '${isDeptBoss}'=="1")))
                || (requesterDept == tTKSPId && status == "教务处待审批")
                ){
                    $("#dialog").load("<%=request.getContextPath()%>/rescheduleCourse/approveRC?id=" + id+"&overruleStatus="+overruleStatus+"&createDept="+createDept+"&tTKSPId="+tTKSPId);
                    $("#dialog").modal("show");
                }
              else {
                  swal({
                      title:"暂无权限",
                      type:"warning"
                  })
                }
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/rescheduleCourse/editRescheduleCourse");
        $("#dialog").modal("show");
    }

    //查询
    function search() {
        rescheduleTable = $("#rescheduleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rescheduleCourse/getRescheduleCourseList',
                "data": {
                    majorSchoolShow: $("#majorSchoolSel").val(),
                    deptId:$("#deptSel").val(),
                    majorShow:$("#majorSel").val(),
                    courseId:$("#courseSel").val(),
                    classId:$("#classSel").val(),
                    applicantPersonId:$("#peopleSel").val(),
                    applicantDate:$("#applicantDateSel").val(),
                    status:$("#statusType").val(),
                    tTKSPId:$("#tTKSPId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "creator", "visible": false},
                {"data": "createDept", "visible": false},
                {"data": "overruleStatus", "visible": false},
                {"width": "11%","data": "majorSchool", "title": "学院"},
                {"width": "11%","data": "majorCode", "title": "专业"},
                {"width": "11%","data": "deptId", "title": "系部"},
                {"width": "11%","data": "classId", "title": "班级"},
                {"width": "11%","data": "courseId", "title": "课程"},
                {"width": "11%","data": "applicantPersonId", "title": "申请人"},
                {"width": "11%","data": "applicantDate", "title": "申请日期"},
                {"width": "11%","data": "status", "title": "状态"},
                {"width": "12%","data": "approveReason", "title": "驳回原因"},
                {"width": "11%", "title": "操作", "render": function () {return "<a id='updReschedule' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delReschedule' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='submit' class='icon-upload-alt' title='提交'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='approve' class='icon-file-text-alt' title='办理'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        })

       /* $("#majorSchoolSel").val("");
        $("#deptSel").val("");
        $("#majorSel").val("");
        $("#courseSel").val("");
        $("#classSel").val("");
        $("#peopleSel").val("");
        $("#applicantDateSel").val("");
        $("#statusType").val("")*/
    }
    function searchClear() {
        $("#majorSchoolSel").val("");
        $("#deptSel").val("");
        $("#majorSel").val("");
        $("#courseSel").val("");
        $("#classSel").val("");
        $("#peopleSel").val("");
        $("#applicantDateSel").val("");
        $("#statusType").val("");
        search()
    }
</script>

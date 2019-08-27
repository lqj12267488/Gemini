<%--
  Created by IntelliJ IDEA.
  User: go
  Date: 2019/6/24
  Time: 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span style="font-size: 14px">${head}</span>
            <input id="id" name="id" type="hidden" value="${rescheduleCourse.id}">
            <input id="overruleStatus" type="hidden" value="${rescheduleCourse.overruleStatus}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学院：
                    </div>
                    <div class="col-md-9">
                        <input ype="text"  class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.majorSchoolShow}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部：
                    </div>
                    <div class="col-md-9">
                        <input  type="text" class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.deptId}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业：
                    </div>
                    <div class="col-md-9">
                        <input  type="text" class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.majorCode}"  readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级：
                    </div>
                    <div class="col-md-9">
                        <input type="text"  class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.classId}"  readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程：
                    </div>
                    <div class="col-md-9">
                        <input  type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.courseId}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        原定周次：
                    </div>
                    <div class="col-md-9">
                        <input  type="text"
                               value= "${rescheduleCourse.oringalWeek}"
                                class="validate[required,maxSize[100]] form-control"
                                readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                         原定上课日期
                    </div>
                    <div class="col-md-9">
                        <input id="oringalDate" type="text"
                               value="${rescheduleCourse.oringalDate}"
                               class="validate[required,maxSize[100]] form-control"
                               readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        原定上课星期：
                    </div>
                    <div class="col-md-9">
                        <input type="text"
                               value="${rescheduleCourse.oringalWeekday}"
                               class="validate[required,maxSize[100]] form-control" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        原定上课节次：
                    </div>
                    <div class="col-md-9">
                        <input type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.oringalClassTime}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        改调上课周次：
                    </div>
                    <div class="col-md-9">
                        <input type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.rescheduleWeek}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                      改调上课日期
                    </div>
                    <div class="col-md-9">
                        <input id="rescheduleDate" type="text"
                               value="${rescheduleCourse.rescheduleDate}"
                               class="validate[required,maxSize[100]] form-control"
                               readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        改调上课星期：
                    </div>
                    <div class="col-md-9">
                        <input id="rescheduleWeekday"  type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.rescheduleWeekday}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        改调上课节次：
                    </div>
                    <div class="col-md-9">
                        <input id="rescheduleClassTime" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.rescheduleClassTime}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请人:
                    </div>
                    <div class="col-md-9">
                        <input id="applicantPersonId" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rescheduleCourse.applicantPersonId}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                         申请理由
                    </div>
                    <div class="col-md-9">
                            <textarea  class="validate[required,maxSize[100]] form-control"
                                      value="${rescheduleCourse.applicantReason}"  readonly>${rescheduleCourse.applicantReason}
                             </textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                     申请时间
                    </div>
                    <div class="col-md-9">
                        <input id="applicantDate" type="text"
                               class="validate[required,maxSize[100]] form-control" readonly
                               value="${rescheduleCourse.applicantDate}"/>
                    </div>
                </div>
                <div id="lastApproveReasonDiv">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            上次驳回原因
                        </div>
                        <div class="col-md-9">
                            <textarea  id="lastApproveReason" class="validate[required,maxSize[100]] form-control" READONLY>${rescheduleCourse.approveReason}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                   驳回原因
                    </div>
                    <div class="col-md-9">
                            <textarea  id="approveReason" class="validate[required,maxSize[100]] form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="approve()">批准
            </button>
            <button type="button" class="btn btn-default btn-clean"  onclick="overrule()">驳回</button>
            <%--data-dismiss="modal"--%>
        </div>
    </div>
</div>
<script>

    $(function () {

        var overruleStatus = $("#overruleStatus").val();
        //如过没有驳回原因，则隐藏
        if (undefined == '${rescheduleCourse.approveReason}' || '' == '${rescheduleCourse.approveReason}') {
            $("#lastApproveReasonDiv").hide();
        }
        if ("2" == overruleStatus){
            $("#saveBtn").hide();
            $("#lastApproveReasonDiv").hide();
            $("#approveReason").attr("readonly","readonly")
            $("#approveReason").val('${rescheduleCourse.approveReason}')
        }

    })
    function approve() {

        $.post("<%=request.getContextPath()%>/rescheduleCourse/approveRCWithDept", {
            id:$("#id").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#rescheduleGrid').DataTable().ajax.reload();
            }else {
                swal({title: msg.msg, type: "error"});
                $("#dialog").modal('hide');
                $('#rescheduleGrid').DataTable().ajax.reload();
            }
        })
    }

    //驳回
    function overrule() {

        if ($("#approveReason").val()=="" ||$("#approveReason").val()== undefined ){
            swal({
                title: "请填写驳回原因",
                type: "info"
            });
            return;
        }

        swal({
            title: "请确认是否要驳回申请?",
            text: "驳回后将无法取消，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "驳回",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/rescheduleCourse/overruleRCWithDept", {
                id:$("#id").val(),
                approveReason:$("#approveReason").val(),
                overruleStatus:$("#overruleStatus").val(),
                createDept:'${createDept}',
                tTKSPId:'${tTKSPId}'
            }, function (msg) {
                swal({title: msg.msg,type: msg.result});
                $("#dialog").modal('hide');
                $('#rescheduleGrid').DataTable().ajax.reload();
            });
        })
    }
</script>

<style type="text/css">
    #lastApproveReasonDiv .col-md-9 {
        position: relative;
        min-height: 1px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 10px;
    }
</style>


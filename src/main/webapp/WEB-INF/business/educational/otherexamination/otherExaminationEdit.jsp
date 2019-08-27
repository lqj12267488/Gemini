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
            <span style="font-size: 14px;">${head}</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            学期
                        </div>
                        <div class="col-md-9">
                            <select id="termSel"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="examNameSel" type="text" placeholder="请输入考试名称" value="${data.examName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 科目
                    </div>
                    <div class="col-md-9">
                        <div>
                            <select id="a_courseId"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考核方式
                    </div>
                    <div class="col-md-9">
                        <select id="examTypeSel" name="examMethod" class="required" msg="请选择考核方式！"></select>
                    </div>
                </div>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span> 考试时间--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="examDate" type="date" placeholder="请输入考试时间" value="${data.examDate}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-row">--%>
                    <%--<div class="col-md-3 tar">--%>
                        <%--<span class="iconBtx">*</span> 上传人--%>
                    <%--</div>--%>
                    <%--<div class="col-md-9">--%>
                        <%--<input id="uploadingPerson" type="text" placeholder="请输入上传人" value="${data.uploadingPerson}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel', '${data.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'examTypeSel', '${data.examType}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE",
                where: "  ",
                orderby: " "
            },
            function (data) {
                addOption(data, "a_courseId",'${data.course}');
            });
    });

    function save() {
        var id = $("#id").val();
        var examName = $("#examNameSel").val();
        // var examDate = $("#examDate").val();
        // var uploadingPerson = $("#uploadingPerson").val();
        var term = $("#termSel").val();
        var courseId = $("#a_courseId").val();
        var examType = $("#examTypeSel").val();

        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请填写科目!",
                type: "info"
            });
            return;
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请填写学期!",
                type: "info"
            });
            return;
        }
        if (examName == "" || examName == undefined || examName == null) {
            swal({
                title: "请填写考试名称!",
                type: "info"
            });
            return;
        }
        if (examType == "" || examType == undefined || examType == null) {
            swal({
                title: "请填写考核方式!",
                type: "info"
            });
            return;
        }
        // if (examDate == "" || examDate == undefined || examDate == null) {
        //     swal({
        //         title: "请填写考试日期!",
        //         type: "info"
        //     });
        //     return;
        // }
        // if (uploadingPerson == "" || uploadingPerson == undefined || uploadingPerson == null) {
        //     swal({
        //         title: "请填写上传人!",
        //         type: "info"
        //     });
        //     return;
        // }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/otherExamination/saveOtherExamination", {
            id: id,
            examName: examName,
            course:courseId,
            term: term,
            examType: examType
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: msg.result});
            if (msg.status == '0') {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            } else {
                return;
            }
        })
    }
</script>




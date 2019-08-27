<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="examTopicid" hidden value="${examTopic.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="f_term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorShow" class="js-example-basic-single">
                            <option value="">请选择系部</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级名称
                    </div>
                    <div class="col-md-9">
                        <select id="classId" class="js-example-basic-single">
                            <option value="">请选择专业</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程
                    </div>
                    <div class="col-md-9">
                        <input id="courseId" value="${examTopic.curriculum}">
                        <%-- <select id="courseId" name="courseId" class="required" msg="请选择班级！">
                             <option value="">请选择专业</option>
                         </select>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        考核类型
                    </div>
                    <div class="col-md-9">
                        <input id="f_assessmentType" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="考查" readonly="true"/>
                        <input id="f_eidtype" type="hidden" value="考查"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input id="dept" value="${examTopic.department}" type="hidden">
    <input id="major" value="${examTopic.majorShow}" type="hidden">
    <input id="class" value="${examTopic.classId}" type="hidden">
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term', '${examTopic.semester}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${examTopic.department}');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function () {
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId=" + $("#departmentsId").val(), function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId=" + $("#dept").val(), function (data) {
            addOption(data, "majorShow", '${examTopic.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function () {
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow=" + $("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow=" + $("#major").val(), function (data) {
            addOption(data, "classId", '${examTopic.classId}');
        })
    })

    function save() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_term").val() == "" || $("#f_term").val() == "0" || $("#f_term").val() == undefined) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }

        if ($("#departmentsId").val() == "" || $("#departmentsId").val() == "0" || $("#departmentsId").val() == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }

        if ($("#majorShow").val() == "" || $("#majorShow").val() == "0" || $("#majorShow").val() == undefined) {
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        if ($("#classId").val() == "" || $("#classId").val() == "0" || $("#classId").val() == undefined) {
            swal({
                title: "请填写班级！",
                type: "info"
            });
            return;
        }
        if ($("#courseId").val() == "" || $("#courseId").val() == "0" || $("#courseId").val() == undefined) {
            swal({
                title: "请填写课程！",
                type: "info"
            });
            return;
        }
        var majorShow = $("#majorShow").val();
        var majorList = majorShow.split(",");
        $.post("<%=request.getContextPath()%>/otherAchievements/saveOtherAchievements", {
            id: $("#examTopicid").val(),
            semester: $("#f_term").val(),
            department: $("#departmentsId").val(),
            majorCode: majorList[0],
            majorDirection: majorList[1],
            trainingLevel: majorList[2],
            classId: $("#classId").val(),
            curriculum: $("#courseId").val(),
            assessmentType: $("#f_assessmentType").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#scoreExamGrid').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
        /* $('#scoreExamGrid').DataTable().ajax.reload();*/
    }

</script>
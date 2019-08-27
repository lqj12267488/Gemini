<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/23
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorShow" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  称号
                    </div>
                    <div class="col-md-4">
                        <input id="title" class="js-example-basic-single" value="三好班级" value="${miyoshiClass.title}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                          班主任
                    </div>
                    <div class="col-md-4">
                        <input id="headTeacher" type="text" value="${miyoshiClass.headTeacherShow}" key="${miyoshiClass.headTeacher}" readonly/>
                    </div>
                    <div class="col-md-2 tar">
                       所在部门
                    </div>
                    <div class="col-md-4">
                        <input id="headTeacherDept" type="text" value="${miyoshiClass.headTeacherDeptShow}" key="${miyoshiClass.headTeacherDept}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 授予单位
                    </div>
                    <div class="col-md-4">
                        <input id="grantUnit" type="text" value="${miyoshiClass.grantUnit}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 授予时间
                    </div>
                    <div class="col-md-4">
                        <input id="grantTime" type="date" value="${miyoshiClass.grantTime}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="id" value="${miyoshiClass.id}" type="hidden" >
    <input id="dept" value="${miyoshiClass.departmentsId}" type="hidden" >
    <input id="major" value="${miyoshiClass.majorShow}" type="hidden" >
    <input id="class" value="${miyoshiClass.classId}" type="hidden" >
    <input id="student" value="${miyoshiClass.studentId}" type="hidden" >
    <input id="flag" value="${flag}" type="hidden">
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${miyoshiClass.departmentsId}');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${miyoshiClass.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId", '${miyoshiClass.classId}');
        })
//通过班级获取班主任和所在部门
        $("#classId").change(function(){
            $.get("<%=request.getContextPath()%>/studentRewardPunish/getHeadTeacherByClassId?classId="+$("#classId").val(),
                function (map) {
                    $("#headTeacher").val(map.headTeacherShow);
                    $("#headTeacher").attr("key",map.headTeacher);
                    $("#headTeacherDept").val(map.headTeacherDeptShow);
                    $("#headTeacherDept").attr("key",map.headTeacherDept);
                }
            )
        });
//查看详情设置控件只读
        if($("#flag").val()=="1"){
            $("#saveBtn").hide();
            $("input").attr('readonly','readonly');
            $("select").attr('disabled','disabled');
        }
    })
    function closeView(){
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
    }
    function save() {
        if ($("#departmentsId").val() == "") {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#majorShow").val() == "") {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if ($("#classId").val() == "") {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if ($("#title").val() == "") {
            swal({
                title: "请填写称号！",
                type: "info"
            });
            return;
        }
        if ($("#grantUnit").val() == "") {
            swal({
                title: "请填写授予单位！",
                type: "info"
            });
            return;
        }
        if ($("#grantTime").val() == "") {
            swal({
                title: "请选择授予时间！",
                type: "info"
            });
            return;
        }
        var majorShow =$("#majorShow").val();
        var majorList = majorShow.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/save", {
            id:$("#id").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: majorList[0],
            majorDirection:majorList[1],
            trainingLevel: majorList[2],
            classId: $("#classId").val(),
            title:$("#title").val(),
            headTeacher:$("#headTeacher").attr("key"),
            headTeacherDept:$("#headTeacherDept").attr("key"),
            grantUnit:$("#grantUnit").val(),
            grantTime:$("#grantTime").val(),
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#miyoshiClassGrid').DataTable().ajax.reload();
        })
    }
</script>

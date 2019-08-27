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
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorShow" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <input id="sex" type="text" value="${fullBurse.sexShow}" key="${fullBurse.sex}" readonly/>
                    </div>
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" value="${fullBurse.idcard}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖学金项目
                    </div>
                    <div class="col-md-4">
                        <select id="burseProgram" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   等级
                    </div>
                    <div class="col-md-4">
                        <select id="burseGrade" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖学金(元)
                    </div>
                    <div class="col-md-4">
                        <input id="burseSum" type="text" value="${fullBurse.burseSum}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   授予时间
                    </div>
                    <div class="col-md-4">
                        <select id="grantTime" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="id" value="${fullBurse.id}" type="hidden" >
    <input id="dept" value="${fullBurse.departmentsId}" type="hidden" >
    <input id="major" value="${fullBurse.majorShow}" type="hidden" >
    <input id="class" value="${fullBurse.classId}" type="hidden" >
    <input id="student" value="${fullBurse.studentId}" type="hidden" >
    <input id="flag" value="${flag}" type="hidden">
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JXJXM", function (data) {
            addOption(data, 'burseProgram','${fullBurse.burseProgram}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JXJDJ", function (data) {
            addOption(data, 'burseGrade','${fullBurse.burseGrade}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'grantTime','${fullBurse.grantTime}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${fullBurse.departmentsId}');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${fullBurse.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId", '${fullBurse.classId}');
        })
//通过班级id获取学生下拉列表
        $("#classId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#classId").val(), function (data) {
                addOption(data, "studentId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#class").val(), function (data) {
            addOption(data, "studentId",'${fullBurse.studentId}');
        })
//通过学生获取性别和身份证号
        $("#studentId").change(function(){
            $.get("<%=request.getContextPath()%>/studentRewardPunish/getStudentSexIdcard?studentId="+$("#studentId").val(),
                function (map) {
                    $("#sex").val(map.sexShow);
                    $("#sex").attr("key",map.sex);
                    $("#idcard").val(map.idcard);
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
        if ($("#studentId").val() == "") {
            swal({
                title: "请选择学生姓名！",
                type: "info"
            });
            return;
        }
        if ($("#burseProgram").val() == "") {
            swal({
                title: "请选择奖学金项目！",
                type: "info"
            });
            return;
        }
        if ($("#burseGrade").val() == "") {
            swal({
                title: "请选择等级！",
                type: "info"
            });
            return;
        }
        if ($("#burseSum").val() == "") {
            swal({
                title: "请填写奖学金金额！",
                type: "info"
            });
            return;
        }
        var reg = new RegExp("^[0-9]+(.[0-9]{1,2})?$");
        if(!reg.test($("#burseSum").val())){
            swal({
                title: "请输入正确的奖学金金额！",
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
        $.post("<%=request.getContextPath()%>/studentRewardPunish/fullBurse/save", {
            id:$("#id").val(),
            studentId:$("#studentId").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: majorList[0],
            majorDirection:majorList[1],
            trainingLevel: majorList[2],
            classId: $("#classId").val(),
            sex:$("#sex").attr("key"),
            idcard:$("#idcard").val(),
            burseProgram:$("#burseProgram").val(),
            burseGrade:$("#burseGrade").val(),
            burseSum:$("#burseSum").val(),
            grantTime:$("#grantTime").val(),
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#fullBurseGrid').DataTable().ajax.reload();
        })
    }
</script>

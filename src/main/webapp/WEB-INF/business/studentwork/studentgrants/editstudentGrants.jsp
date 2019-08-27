<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/28
  Time: 14:47
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
            <input id="studentGrantsIdd" type="hidden" value="${studentGrants.id}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" type="text" onchange="changeEditMajor()"></select>
                    </div>

                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorCode" type="text" value="${studentGrants.majorCode}"onchange="changeEditClass()"></select>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" type="text"  value="${studentGrants.classId}" onchange="changeEditClassID()"></select>
                    </div>
                    <div class="col-md-2 tar">
                        培养层次
                    </div>
                    <div class="col-md-4">
                        <input readonly id="trainingLevel" class="js-example-basic-single" value="${studentGrants.trainingLevel}"></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId"></select>
                    </div>
                    <div class="col-md-2 tar">
                        学期
                    </div>
                    <div class="col-md-4">
                        <select id="term" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        助学金类别
                    </div>
                    <div class="col-md-4">
                        <select id="grantType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        金额
                    </div>
                    <div class="col-md-4">
                        <input id="money" type="text" value="${studentGrants.money}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveClass()" onclick="changeEditClassID()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentGrants.departmentsId}');
        });
//      专业回显
        if ('${studentGrants.majorCode}' != "") {//判断需要回显的专业Code是否为空
            var deptId = '${studentGrants.departmentsId}';//获取回显的系部id
            $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//通过系部id查询专业id和名称
                addOption(data, 'majorCode', '${studentGrants.majorCode}');//将回显的专业id通过下拉选项转换为专业名称
            });
        } else {//如果回显专业为空,下拉列表显示请选择
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }
//       班级回显
        if ('${studentGrants.classId}' != "") {
            var majorCode = '${studentGrants.majorCode}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: " t_xg_class ",
                where: " WHERE 1 = 1 and major_code = '"+ majorCode +"'" ,
                orderby: " order by create_time desc"
            },function (data) {
                addOption(data, "classId", '${studentGrants.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>");
        }
//      学生和培养层次回显
        if ('${studentGrants.studentId}' != "") {
            var classId = '${studentGrants.classId}';
            $.post("<%=request.getContextPath()%>/studentGrants/getTrainingLevelByClassId",{
                classId:classId
            },function (data) {
                $("#trainingLevel").val(data.showValue);
                $("#trainingLevel").attr("storeValue",data.storeValue);
            })
            $.post("<%=request.getContextPath()%>/studentGrants/getStudentByClassId", {
                classId:classId
            },function (data) {
            addOption(data, "studentId", '${studentGrants.studentId}');
            });
        }else {
            $("#studentId").append("<option value='' selected>请选择</option>");
        }
//      系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXJLB", function (data) {
            addOption(data, 'grantType', '${studentGrants.grantTypeShow}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term','${studentGrants.term}');
        });
    })
    function saveClass() {
        if ($("#departmentsId option:selected").val() == "") {
             swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#majorCode").val() == "") {
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
        if ($("#trainingLevel").attr("storeValue") == "") {
             swal({
                title: "请填写培养层次！",
                type: "info"
            });
            return;
        }
        if ($("#studentId").val() == ""||$("#studentId").val() ==null) {
             swal({
                title: "请选择学生姓名！",
                type: "info"
            });
            return;
        }
        if ($("#term").val() == "") {
             swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if ($("#grantType option:selected").val() == "") {
             swal({
                title: "请选择助学金类别！",
                type: "info"
            });
            return;
        }
        if ($("#money").val() == "") {
             swal({
                title: "请填写助学金金额！",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        if(!reg.test($("#money").val())){
            swal({
                title: "助学金金额请填写数字！",
                type: "info"
            });
            return;
        }
        var classId = $("#classId option:selected").val();
        var departmentsId = $("#departmentsId option:selected").val();
        var majorCode = $("#majorCode option:selected").val();
        var studentId =$("#studentId  option:selected").val();
        var trainingLevel =$("#trainingLevel").attr("storeValue");
        var term = $("#term").val();
        var grantType = $("#grantType").val();
        var money = $("#money").val();
        $.post("<%=request.getContextPath()%>/studentGrants/saveStudentGrants", {
            id:$("#studentGrantsIdd").val(),
            classId: classId,
            studentId:studentId,
            majorCode: majorCode,
            departmentsId: departmentsId,
            trainingLevel: $("#trainingLevel").attr("storeValue"),
            grantType:grantType,
            money:money,
            term:term
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#studentGrantsTable').DataTable().ajax.reload();

        })
    }
    //选择系部后,根据系部id查询下属专业
    function changeEditMajor() {
        var deptId = $("#departmentsId").val();//获取当前选择的系部id
        $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//通过已选择的系部id查询专业
            addOption(data, 'majorCode');
        });
    }
    //选择专业后,根据系部id查询下属班级
    function changeEditClass() {
        var majorCode = $("#majorCode").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: " t_xg_class ",
                where: " WHERE 1 = 1 and major_code = '"+ majorCode +"'" ,
                orderby: " order by create_time desc"
            },function (data) {
                addOption(data, "classId");
            });
    }
    //选择班级后,显示培养层次,查询班内所有学生
    function changeEditClassID() {
        var classId = $("#classId").val();
        $.post("<%=request.getContextPath()%>/studentGrants/getTrainingLevelByClassId",{
            classId:classId
        },function (data) {
            $("#trainingLevel").val(data.showValue);
            $("#trainingLevel").attr("storeValue",data.storeValue);
        })
        $.post("<%=request.getContextPath()%>/studentGrants/getStudentByClassId", {
                classId:classId
            },function (data) {
                addOption(data, "studentId", '${studentGrants.studentId}');
        });
    }
</script>

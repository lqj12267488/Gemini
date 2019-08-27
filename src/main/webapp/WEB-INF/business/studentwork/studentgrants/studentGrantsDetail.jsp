<%--详情查看
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/5
  Time: 17:42
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
            <input id="studentGrantsId" type="hidden" value="${studentGrants.id}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" disabled="disabled" type="text" onchange="changeEditMajor()"></select>
                    </div>

                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorCode" disabled="disabled" type="text" "onchange="changeEditClass()"></select>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" disabled="disabled" type="text"  value="${studentGrants.classId}" onchange="changeEditClassID()"></select>
                    </div>
                    <div class="col-md-2 tar">
                        培养层次
                    </div>
                    <div class="col-md-4">
                        <input id="trainingLevel" readonly="readonly" class="js-example-basic-single" value="${studentGrants.trainingLevel}"></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        学生姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" disabled="disabled"></select>
                    </div>
                    <div class="col-md-2 tar">
                        学期
                    </div>
                    <div class="col-md-4">
                        <select id="term" disabled="disabled" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        助学金类别
                    </div>
                    <div class="col-md-4">
                        <select id="grantType" disabled="disabled" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        金额
                    </div>
                    <div class="col-md-4">
                        <input id="money" readonly="readonly" type="text" value="${studentGrants.money}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        创建人
                    </div>
                    <div class="col-md-4">
                        <input id="creator" type="text"
                               value="${studentGrants.creator}" readonly="readonly"/>
                    </div>
                    <div class="col-md-2 tar">
                        创建时间
                    </div>
                    <div class="col-md-4">
                        <input id="createTime" type="text" readonly
                               value="${studentGrants.createTime}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <%-- <button type="button" class="btn btn-success btn-clean" onclick="saveClass()" onclick="changeEditClassID()">保存</button>--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script>

    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentGrants.departmentsId}');
        });
//majorCode
        if ('${studentGrants.majorCode}' != "") {
            var deptId = '${studentGrants.departmentsId}';
            $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${studentGrants.majorCode}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }
//       班级Id
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
</script>

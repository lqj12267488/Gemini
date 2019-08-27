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
                        <span class="iconBtx">*</span>   班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   姓名
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
                        <input id="sex" type="text" value="${studentLoan.sexShow}" key="${studentLoan.sex}" readonly/>
                    </div>
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" value="${studentLoan.idcard}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>     贷款金额
                    </div>
                    <div class="col-md-4">
                        <input id="loanSum" type="text" value="${studentLoan.loanSum}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   贷款年度
                    </div>
                    <div class="col-md-4">
                        <select id="loanYear" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="id" value="${studentLoan.id}" type="hidden" >
    <input id="dept" value="${studentLoan.departmentsId}" type="hidden" >
    <input id="major" value="${studentLoan.majorShow}" type="hidden" >
    <input id="class" value="${studentLoan.classId}" type="hidden" >
    <input id="student" value="${studentLoan.studentId}" type="hidden" >
    <input id="flag" value="${flag}" type="hidden">
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'loanYear','${studentLoan.loanYear}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentLoan.departmentsId}');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${studentLoan.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId", '${studentLoan.classId}');
        })
//通过班级id获取学生下拉列表
        $("#classId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#classId").val(), function (data) {
                addOption(data, "studentId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#class").val(), function (data) {
            addOption(data, "studentId",'${studentLoan.studentId}');
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
        if ($("#title").val() == "") {
             swal({
                title: "请选择称号！",
                type: "info"
            });
            return;
        }
        if ($("#loanSum").val() == "") {
            swal({
                title: "请填写贷款金额！",
                type: "info"
            });
            return;
        }
        var reg = new RegExp("^[0-9]+(.[0-9]{1,2})?$");
        if(!reg.test($("#loanSum").val())){
             swal({
                title: "请输入正确的贷款金额！",
                type: "info"
            });
            return;
        }
        if ($("#loanYear").val() == "") {
             swal({
                title: "请选择贷款年度！",
                type: "info"
            });
            return;
        }
        var majorShow =$("#majorShow").val();
        var majorList = majorShow.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/studentRewardPunish/studentLoan/save", {
            id:$("#id").val(),
            studentId:$("#studentId").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: majorList[0],
            majorDirection:majorList[1],
            trainingLevel: majorList[2],
            classId: $("#classId").val(),
            sex:$("#sex").attr("key"),
            idcard:$("#idcard").val(),
            loanSum:$("#loanSum").val(),
            loanYear:$("#loanYear").val(),
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#studentLoanGrid').DataTable().ajax.reload();
        })
    }
</script>

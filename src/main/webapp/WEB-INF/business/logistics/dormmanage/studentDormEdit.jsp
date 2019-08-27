<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/21
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
                        <span class="iconBtx" id="xibu">*</span>系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx" id="zhuanye">*</span>专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorShow" class="js-example-basic-single"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx" id="banji">*</span>班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx" id="xingming">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" class="js-example-basic-single" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>联系电话
                    </div>
                    <div class="col-md-4">
                        <input id="tel" type="text" value="${studentDorm.tel}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="11" placeholder="最多输入11位字"/>
                    </div>
                    <div class="col-md-2 tar">

                    </div>
                    <div class="col-md-4">

                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <input id="sex" type="text" value="${studentDorm.sexShow}" key="${studentDorm.sex}" readonly placeholder="无需输入，自动生成"/>
                    </div>
                    <div class="col-md-2 tar">
                         身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" value="${studentDorm.idcard}" readonly placeholder="无需输入，自动生成"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="studentDormId" value="${studentDorm.studentDormId}" type="hidden" >
    <input id="dept" value="${studentDorm.departmentsId}" type="hidden" >
    <input id="major" value="${studentDorm.majorShow}" type="hidden" >
    <input id="class" value="${studentDorm.classId}" type="hidden" >
    <input id="student" value="${studentDorm.studentId}" type="hidden">
    <input id="telShow" value="${studentDorm.tel}" hidden>
    <input id="flag" value="${flag}" type="hidden">
</div>

<script>
    var studentDormId = $("#studentDormId").val();
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
        if(studentDormId!=''){
            $("#departmentsId").attr("disabled",true);
            $("#majorShow").attr("disabled",true);
            $("#classId").attr("disabled",true);
            $("#studentId").attr("disabled",true)
            $("#xibu").html("");
            $("#zhuanye").html("");
            $("#banji").html("");
            $("#xingming").html("");
        }
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentDorm.departmentsId}');
        });
//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $("#majorShow").val("");
            $("#classId").val("");
            $("#studentId").val("");
            $("#tel").val("");
            $("#sex").val("");
            $("#idcard").val("");
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${studentDorm.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $("#classId").val("");
            $("#studentId").val("");
            $("#tel").val("");
            $("#sex").val("");
            $("#idcard").val("");
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId", '${studentDorm.classId}');
        })
//通过班级id获取学生下拉列表
        $("#classId").change(function(){
            $("#studentId").val("");
            $("#tel").val("");
            $("#sex").val("");
            $("#idcard").val("");
            $.get("<%=request.getContextPath()%>/dormmanage/getStudentByClassIdNotDorm?classId="+$("#classId").val(), function (data) {
                addOption(data, "studentId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#class").val(), function (data) {
            addOption(data, "studentId",'${studentDorm.studentId}');
        })
//通过学生获取性别和身份证号
        $("#studentId").change(function(){
            $("#tel").val("");
            $("#sex").val("");
            $("#idcard").val("");
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

    function checkstudent() {
        $.post("<%=request.getContextPath()%>/dormmanage/checktsudentdorm", {
            studentId:$("#studentId").val()
        }, function (msg) {
            if(msg.status=='1'){
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }

        })
    }

    function onchangeStudent() {
        $("#tel").val("");
        $("#sex").val("");
        $("#idcard").val("");

        $.post("<%=request.getContextPath()%>/dormmanage/checktsudentdorm", {
            studentId:$("#studentId").val(),
            studentDormId:studentDormId
        }, function (msg) {
            if(msg.status=='1'){
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }else{
                $.get("<%=request.getContextPath()%>/studentRewardPunish/getStudentSexIdcard?studentId="+ $("#studentId").val(),
                    function (map) {
                        $("#sex").val(map.sexShow);
                        $("#sex").attr("key",map.sex);
                        $("#idcard").val(map.idcard);
                    }
                )
            }

        })
    }
    function save() {
       /* checkstudent();*/
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
        if($("#tel").val() ==""){
            swal({
                title: "请填写电话！",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+.?[0-9]*$/;
        var regTel = /^1[0-9]{10}$/;
        if (!reg.test($("#tel").val())) {
            swal({
                title: "联系方式填写数字！",
                type: "info"
            });
            return;
        } else if (!regTel.test($("#tel").val())) {
            swal({
                title: "联系方式请填写11位手机号！",
                type: "info"
            });
            return;
        }
       if($("#idcard").val()==''||$("#idcard").val()==null){
            if($("#sex").attr("key")==''||$("#sex").attr("key")==null){
                swal({
                    title: "该学生已存在，请重新选择！",
                    type: "info"
                });
                return;
            }
       }
        var majorShow =$("#majorShow").val();
        var majorList = majorShow.split(",");
        showSaveLoading();
        if(studentDormId !='' && $('#stuentId').val()==$('#stuent').val()){
            $.post("<%=request.getContextPath()%>/dormmanage/studentdorm/save", {
                studentDormId: $("#studentDormId").val(),
                studentId: $("#studentId").val(),
                departmentsId: $("#departmentsId").val(),
                majorCode: majorList[0],
                majorDirection: majorList[1],
                trainingLevel: majorList[2],
                classId: $("#classId").val(),
                sex: $("#sex").attr("key"),
                idcard: $("#idcard").val(),
                tel: $("#tel").val()
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#schoolBurseGrid').DataTable().ajax.reload();
            })
        }else{


        $.post("<%=request.getContextPath()%>/dormmanage/checktsudentdorm", {
            studentId:$("#studentId").val(),
            studentDormId:studentDormId
        }, function (msg) {
            if(msg.status=='1'){
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }else {
                $.post("<%=request.getContextPath()%>/dormmanage/studentdorm/save", {
                    studentDormId: $("#studentDormId").val(),
                    studentId: $("#studentId").val(),
                    departmentsId: $("#departmentsId").val(),
                    majorCode: majorList[0],
                    majorDirection: majorList[1],
                    trainingLevel: majorList[2],
                    classId: $("#classId").val(),
                    sex: $("#sex").attr("key"),
                    idcard: $("#idcard").val(),
                    tel: $("#tel").val()
                }, function (msg) {
                    hideSaveLoading();
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal('hide');
                    $('#schoolBurseGrid').DataTable().ajax.reload();
                })
            }})
        }
        hideSaveLoading();
    }
</script>

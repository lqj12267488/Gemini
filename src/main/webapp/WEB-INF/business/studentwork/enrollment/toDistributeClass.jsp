<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog">
    <input type="hidden" name="ids" id="ids" value="${ids}">
    <input type="hidden" name="id" id="id" value="${id}">
    <input type="hidden" name="flag" id="flag" value="${flag}">
    <input type="hidden" name="status" id="status" value="${status}">
    <input type="hidden" name="departmentsId" id="departmentsId" value="${enrollmentStudent.departmentsId}">
    <input type="hidden" name="majorCode" id="majorCode" value="${enrollmentStudent.majorCode}">
    <input type="hidden" name="majorDirection" id="majorDirection" value="${enrollmentStudent.majorDirection}">
    <input type="hidden" name="trainingLevel" id="trainingLevel" value="${enrollmentStudent.trainingLevel}">
    <input type="hidden" name="classId" id="classId" value="${enrollmentStudent.classId}">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系部:
                    </div>
                    <div class="col-md-9">
                        <select id="dept_id" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业:
                    </div>
                    <div class="col-md-9">
                        <select id="major_id" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级:
                    </div>
                    <div class="col-md-9">
                        <select id="class_id" ></select>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="distributeClass()">分班</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var status=$("#status").val();
        var classId=$("#classId").val();
        var classId=$("#ids").val();
        if(status==1){
            //系部回显
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " dept_id",
                    text: " dept_name ",
                    tableName: "T_SYS_DEPT",
                    where: " WHERE DEPT_TYPE =8 ",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "dept_id", $("#departmentsId").val());
                });
            //专业回显
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1 and departments_id='"+$("#departmentsId").val()+"')",
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    var up_major = $("#majorCode").val() +","+$("#majorDirection").val()+","+$("#trainingLevel").val();
                    addOption(data, "major_id",up_major);
                });
            if(classId==null){
                //班级初始化
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " code ",
                        text: " value ",
                        tableName: "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1 and major_code ='"+$("#majorCode").val()+"' and major_direction='"+ $("#majorDirection").val()+"' AND training_level='"+ $("#trainingLevel").val()+"')",
                        where: " ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, "class_id");
                    })
            }else{
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " code ",
                        text: " value ",
                        tableName: "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1 and major_code ='"+$("#majorCode").val()+"' and major_direction='"+ $("#majorDirection").val()+"' AND training_level='"+ $("#trainingLevel").val()+"')",
                        where: " ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, "class_id", $("#classId").val());
                    })
            }

        }
        if(status==2){
            //系部初始化
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " dept_id",
                    text: " dept_name ",
                    tableName: "T_SYS_DEPT",
                    where: " WHERE DEPT_TYPE =8 ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "dept_id");
                });
            var dept_id=  $("#dept_id option:selected").val();
            var major_id=  $("#major_id option:selected").val();
            if(dept_id == null){
                $("#major_id").html("<option>请选择系部</option>");
            }
            if(major_id == null){
                $("#class_id").html("<option>请选择专业</option>");
            }
        }






        //系部联动专业
        $("#dept_id").change(function(){
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if($("#dept_id option:selected").val()!=null) {
                major_sql+= " and departments_id ='"+$("#dept_id option:selected").val()+"' ";
            }
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "major_id");
                })
        });
        //专业联动班级
        $("#major_id").change(function(){
            var major_id=$("#major_id option:selected").val();
            var majorCode=major_id.split(",")[0];
            var majorDirection=major_id.split(",")[1];
            var trainingLevel=major_id.split(",")[2];
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if($("#major_id option:selected").val()!="") {
                class_sql+= " and major_code ='"+majorCode+"' and major_direction='"+majorDirection+"' AND training_level='"+trainingLevel+"' ";
            }
            class_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "class_id");
                })

        });

     /*  */

    })


    //分班
    function distributeClass() {
        var deptId = $("#dept_id option:selected").val();
        var major_id = $("#major_id option:selected").val();
        var majorCode=major_id.split(",")[0];
        var majorDirection=major_id.split(",")[1];
        var trainingLevel=major_id.split(",")[2];
        var classId = $("#class_id option:selected").val();
        if(deptId == "" || deptId == undefined || deptId == null){
            swal({
                title: "请选择系部!",
                type: "info"
            });
            return;
        }
        if(major_id == "" || major_id == undefined || major_id == null){
            swal({
                title: "请选择专业!",
                type: "info"
            });
            return;
        }
        if(classId == "" || classId == undefined || classId == null){
            swal({
                title: "请选择班级!",
                type: "info"
            });
            return;
        }
            var  ids=$("#ids").val();
            var  id=$("#id").val();
            var  flag=$("#flag").val();
         if(flag=="all"){
             swal({
                 title: "您确定要批量分班?",
                 //text: "专业名称："+majorShow+"\n\n删除后将无法恢复，请谨慎操作！",
                 type: "warning",
                 showCancelButton: true,
                 cancelButtonText: "取消",
                 confirmButtonColor: "green",
                 confirmButtonText: "确定",
                 closeOnConfirm: false
             }, function () {
                 $.post("<%=request.getContextPath()%>/enrollment/doDistributeClass", {
                     deptId: deptId,
                     majorCode: majorCode,
                     trainingLevel:trainingLevel,
                     majorDirection:majorDirection,
                     classId:classId,
                     ids:ids

                 }, function (msg) {
                     if(msg.status==1){
                         swal({
                             title: msg.msg,
                             type: "error"
                         });
                     }else{
                         swal({
                             title: msg.msg,
                             type: "success"
                         });
                         $("#dialog").modal('hide');
                         $('#distributeGrid').DataTable().ajax.reload();
                     }

                 })

             });

        }
        if(flag=="single"){
            swal({
                title: "您确定要分班?",
                //text: "专业名称："+majorShow+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                showSaveLoading();
                $.post("<%=request.getContextPath()%>/enrollment/doDistributeClass", {
                    deptId: deptId,
                    majorCode: majorCode,
                    trainingLevel:trainingLevel,
                    majorDirection:majorDirection,
                    classId:classId,
                    id:id

                }, function (data) {
                    hideSaveLoading();
                    if(data.status==1){
                        swal({
                            title: data.msg,
                            type: "error"
                        });
                    }else{
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $("#dialog").modal('hide');
                        $('#distributeGrid').DataTable().ajax.reload();
                    }

                })

            });

        }
    }

</script>


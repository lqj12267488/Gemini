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
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select  id="dept_id" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select  id="major_id" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级
                    </div>
                    <div class="col-md-9">
                        <select  id="class_id" onchange="changeStudentData()" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学生姓名
                    </div>
                    <div class="col-md-9">
                        <input id="name" placeholder="请输入学生姓名"  name="name"  type="text"  onchange="changeDormData()" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        旷寝时间
                    </div>
                    <div class="col-md-9">
                        <input id="time"  name="time"  type="date" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                       旷寝原因
                    </div>
                    <div class="col-md-9">
                        <input id="reason"  name="reason"  type="text" />
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {

        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "dept_id");
            });
        //系部联动专业
        $("#dept_id").change(function(){
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if($("#dept_id option:selected").val()!="") {
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
            var major_id= $("#major_id option:selected").val();
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if(major_id!="") {
                var majorCode=major_id.split(",")[0];
                var trainingLevel=major_id.split(",")[1];
                class_sql+= "and major_code ='"+majorCode+"' and training_level='"+trainingLevel+"' ";
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


    })

    //班级联动学生姓名
    function  changeStudentData(){
        var class_id = $("#class_id option:selected").val();
        if(class_id == "" || class_id == undefined || class_id == null){

        }else{
            $.get("<%=request.getContextPath()%>/dorm/student/away/autoCompleteStudentByAway?classId="+class_id, function (data) {
                $("#name").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#name").val(ui.item.label);
                        $("#name").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }

    }


    function save() {
        var dept_id = $("#dept_id option:selected").val();
        var major_id = $("#major_id option:selected").val();
        var class_id = $("#class_id option:selected").val();
        var majorCode=major_id.split(",")[0];
        var trainingLevel=major_id.split(",")[1];
        var name = $("#name").attr("keycode");
        var studentId="";
        var classId="";
        var dormId="";
        if(name == "" || name == undefined || name == null){

        }else{
            studentId=name.split(",")[0];
            classId =name.split(",")[1];
            dormId =name.split(",")[2];
        }
        var time =$("#time").val();
        var reason = $("#reason").val();
        if(dept_id == "" || dept_id == undefined || dept_id == null){
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if(major_id == "" || major_id == undefined || major_id == null){
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if(class_id == "" || class_id == undefined || class_id == null){
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if(name == "" || name == undefined || name == null){
            swal({
                title: "请输入学生姓名！",
                type: "info"
            });
            return;
        }
        if(time == "" || time == undefined || time == null){
            swal({
                title: "请选择旷寝时间！",
                type: "info"
            });
            return;
        }
        if(reason == "" || reason == undefined || reason == null){
            swal({
                title: "请填写旷寝原因！",
                type: "info"
            });
            return;
        }
        swal({
            title: "您确定要保存当前数据?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: " 确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dorm/student/away/saveAwayDorm", {
                dormId: dormId,
                studentId: studentId,
                departmentsId:dept_id,
                classId:class_id,
                majorCode:majorCode,
                trainingLevel:trainingLevel,
                awayTime:time,
                awayReason:reason
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#awayGrid').DataTable().ajax.reload();

            })

        });
    }

</script>


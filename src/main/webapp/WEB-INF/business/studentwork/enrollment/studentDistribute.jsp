<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="form-row">
                                <div class="col-md-1 tar">
                                    系部:
                                </div>
                                <div class="col-md-2">
                                    <select id="did" class="js-example-basic-single"></select>
                                </div>
                                <div class="col-md-1 tar">
                                    专业:
                                </div>
                                <div class="col-md-2">
                                    <select id="mid" class="js-example-basic-single"></select>
                                </div>
                                <div class="col-md-1 tar">
                                    班级:
                                </div>
                                <div class="col-md-2">
                                    <select id="cid" class="js-example-basic-single"></select>
                                </div>
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学号:
                            </div>
                            <div class="col-md-2">
                                <input class="validate[required,maxSize[20]] form-control"
                                       id="number" type="text" placeholder="请输入学号" />
                            </div>
                            <div class="col-md-1 tar">
                                身份证号:
                            </div>
                            <div class="col-md-2">
                                <input class="validate[required,maxSize[20]] form-control"
                                       id="card" type="text" placeholder="请输入身份证号" />
                            </div>
                            <div class="col-md-1 tar">
                                姓名:
                            </div>
                            <div class="col-md-2">
                                <input class="validate[required,maxSize[20]] form-control"
                                       id="name" type="text" placeholder="请输入学生姓名" />
                            </div>
                            <div class="col-md-2" >
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batchDistributeClass()">批量分班
                        </button>
                    </div>

                    <table id="distributeGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>studentId</th>
                            <th>departmentsId</th>
                            <th>majorCode</th>
                            <th>trainingLevel</th>
                            <th width="5%">学籍号</th>
                            <th width="10%">学生姓名</th>
                            <th width="5%">性别</th>
                            <th width="10%">身份证号</th>
                            <th width="10%">系部</th>
                            <th width="10%">专业</th>
                            <th width="10%">班级</th>
                            <th width="5%">分班状态</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var distributeTable;
    var dothis ="<a id='distributeClass' class='icon-flag-alt' title='分班'></a>"
    $(document).ready(function () {
        var did=  $("#did option:selected").val();
        var mid=  $("#mid option:selected").val();
        if(did == null || did==undefined){
            $("#mid").html("<option value=''>请先选择系部</option>");
        }
        if(mid == null || mid==undefined){
            $("#cid").html("<option value=''>请先选择专业</option>");
        }
        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "did");
            });
        //系部联动专业、班级
        $("#did").change(function(){
            //系部联动专业
            var did= $("#did option:selected").val();
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(did!=null) {
                major_sql+= " and departments_id ='"+did+"' ";
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "mid");
                })
            }
            //系部切换重新加载班级
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if(did !=null && did!="" ) {
                class_sql+= " and departments_id ='"+did+"' ";
                class_sql+=")";
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " code ",
                        text: " value ",
                        tableName: class_sql,
                        where: " ",
                        orderby: " "
                    },
                    function (data) {
                        addOption(data, "cid");
                    })
            }

        });
        //专业联动班级
        $("#mid").change(function(){
            var mid= $("#mid option:selected").val();
            var did= $("#did option:selected").val();
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if(did !=null && did!="" && mid!=null && mid!="") {
                var mid=$("#mid option:selected").val();
                var majorCode=mid.split(",")[0];
                var majorDirection=mid.split(",")[1];
                var trainingLevel=mid.split(",")[2];
                class_sql+= " and major_code ='"+majorCode+"' and major_direction='"+majorDirection+"' and training_level='"+trainingLevel+"' ";
            class_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "cid");
                })
            }

        });
        distributeTable = $("#distributeGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getDistributeStudentList'
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.studentId + "'/>";
                    }
                },
                {"data": "studentId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"width": "5%", "data": "studentNumber", "title": "学籍号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "5%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "classShow", "title": "班级"},
                {"width": "5%", "data": "cutFlag", "title": "状态"},
                {"width":"10%","title": "操作","render": function () {return dothis;}}

            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        distributeTable.on('click', 'tr a', function () {
            var data = distributeTable.row($(this).parent()).data();
            var id = data.studentId;
            if (this.id == "distributeClass") {
                $.get("<%=request.getContextPath()%>/enrollment/checkDistributeClass?id="+id, function (data) {
                    if(data.status==1){
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                    }else{
                        $("#dialog").load("<%=request.getContextPath()%>/enrollment/toDistributeClass?id=" + id);
                        $("#dialog").modal("show");
                    }
                })

            }

        });
    });

    function batchDistributeClass() {
        var ids = '';
        var length=$('input[name="checkbox"]:checked').length;
        if (length > 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  +"',";

            });
            ids = ids.substring(0,ids.length-1);
            $("#dialog").load("<%=request.getContextPath()%>/enrollment/toDistributeClass?ids="+ids);
            $("#dialog").modal("show");
        } else if(length<2){
            swal({
                title: "请至少选择两个学生!",
                type: "info"
            });
        }else{
            swal({
                title: "请选择要设置的学生!",
                type: "info"
            });
        }
    }

    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }


    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var number=$("#number").val();
        var card=$("#card").val();
        var name=$("#name").val();
        var majorCode=mid.substring(0,5);
        var majorDirection= mid.substring(6,8);
        var trainingLevel= mid.substring(9,mid.length);
        distributeTable.ajax.url("<%=request.getContextPath()%>/enrollment/getDistributeStudentList?departmentsId="+did+"&majorCode="+majorCode+"&majorDirection="+majorDirection+"&trainingLevel="+trainingLevel+"&classId="+cid+"&studentNumber="+number+"&idcard="+card+"&name="+name).load();
    }

    function searchclear() {
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#cid option:selected").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");

        $("#mid").html("<option value=''>请选择系部</option>");
        $("#cid").html("<option value=''>请选择专业</option>");
        $("#name").val("");
        $("#number").val("");
        $("#card").val("");
        distributeTable.ajax.url("<%=request.getContextPath()%>/enrollment/getDistributeStudentList").load();
    }
</script>





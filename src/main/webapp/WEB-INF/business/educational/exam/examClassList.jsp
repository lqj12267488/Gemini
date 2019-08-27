<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${name} > 设置班级</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="did" class="js-example-basic-single" onchange="changeSearchDept()"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single">
                                    <option value="">请选择系部</option>
                                </select>
                            </div>
                            <div class="col-md-1 tar">
                                考试科目：
                            </div>
                            <div class="col-md-2">
                                <select id="cid" class="js-example-basic-single">
                                    <option value="">请选择专业</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchex()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchcl()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="edit()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="importClassData()">落课表导入班级数据
                        </button>
                        <br>
                    </div>
                    <table id="grid" cellpadding="0" cellspacing="0" width="100%" class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;

    function changeSearchDept() {
        var deptId = $("#did").val();
        $.post("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId", {
            deptId: deptId
        }, function (data) {
            addOption(data, 'mid');
        });
    }

    <%--function changeSearchMajor() {--%>
        <%--var majorId = $("#mid").val();--%>
        <%--$.post("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow", {--%>
            <%--majorShow: majorId.split(",")[0] + "," + majorId.split(",")[1],--%>
        <%--}, function (data) {--%>
            <%--addOption(data, 'cid');--%>
        <%--});--%>
    <%--}--%>

    function importClassData() {
        $.post("<%=request.getContextPath()%>/exam/importClassData", {
            id: '${id}'
        }, function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            });
            $('#grid').DataTable().ajax.reload();
        });
    }

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'did');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'cid');
        });
        table = $("#grid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/getExamClassList?examId=${id}',
            },
            "destroy": true,
            "columns": [
                {"data": "departmentsId", "title": "系部"},
                {"data": "majorCode", "title": "专业"},
                {"data": "classId", "title": "班级"},
                {"data": "courseId", "title": "考试科目"},
                {
                    "title": "考试方式",
                    "render": function (data, type, row) {
                        var s = "";
                        switch (row.examType) {
                            case '1':
                                s = "普通";
                                break;
                            case '3':
                                s = '机考';
                                break;
                        }
                        return s;
                    }
                },
                {"data": "examMethod", "title": "考核方式"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toEditExamClass", {
            id: id,
            examId: "${id}",
            term:"${term}"
        });
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/delExamClass", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#grid').DataTable().ajax.reload();
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam");
    }

    function searchcl() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#cid option:selected").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamClassList?examId=${id}").load();
    }

    function searchex() {
        var did= $("#did option:selected").val();
        var mid=$("#mid option:selected").val().split(",")[0];
        var cid=$("#cid option:selected").val();
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamClassList?examId=${id}" + "&departmentsId="+did+"&majorCode="+mid+"&courseId="+cid).load();
    }

</script>
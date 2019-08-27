<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <input id="examId" name="examId" value="${examId}" hidden>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 设置考生</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="did" class="js-example-basic-single" onchange="changeMajor()"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single" onchange="changeClass()">
                                    <option value="">请选择系部</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white">
                        <div class="col-md-1 tar">
                            班级：
                        </div>
                        <div class="col-md-2">
                            <select id="cid" class="js-example-basic-single">
                                <option value="">请选择专业</option>
                            </select>
                        </div>
                        <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                            学生姓名：
                        </div>
                        <div class="col-md-2">
                            <input id="stu_name" style="width: 98.5%;" type="text"
                                   class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    id="batch_button" onclick="batchAddExamStudent()">批量添加考生
                            </button>
                        </div>
                    </div>
                    <table id="examStudentTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
                        <img src="<%=request.getContextPath()%>/../../../libs/img/app/loading.gif" style="height: 50px;text-align: center"/>
                        <h3>正在操作中，请稍后……</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="modal_default_1" tabindex="111" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">修改考生状态</h4>
            </div>
            <div class="modal-body clearfix">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考试状态
                    </div>
                    <div class="col-md-9">
                        <input id="examStudentId" hidden>
                        <select id="status">
                            <option value="0">正常</option>
                            <option value="1">缓考</option>
                            <option value="2">超旷</option>
                            <option value="3">当兵</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="saveStatus()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<script>

    function saveStatus() {
        var examStudentId = $("#examStudentId").val();
        var status = $("#status").val();
        swal({
            title: "确定要修改考生状态?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/student/saveStatus", {
                id: examStudentId,
                status: status
            }, function (data) {
                $("examStudentId").val("");
                swal({title: data.msg, type: "success"});
                $('#examStudentTable').DataTable().ajax.reload();
            });
        })
    }

    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/exam/studuent/autoCompleteStudent", function (data) {
            $("#stu_name").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#stu_name").val(ui.item.label);
                    $("#stu_name").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
            };
        });
 /*       //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "did");
            });
        //系部联动专业
        $("#did").change(function () {
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#did option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#did option:selected").val() + "' ";
            }
            major_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "mid");
                })
        });
        //专业联动班级
        $("#mid").change(function () {
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if ($("#mid option:selected").val() != "") {
                class_sql += "and major_code ='" + $("#mid option:selected").val().substring(0, 6) + "' and training_level='" + $("#mid option:selected").val().substring(7, $("#mid option:selected").val().length) + "' ";
            }
            class_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "cid");
                })

        });*/

        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'did', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var did = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + did, function (data) {
                addOption(data, 'mid', '${data.majorCode},${data.trainingLevel}');
            });
        } else {
            $("#mid").append("<option value='' selected>请选择</option>")
        }

        if ('${data.majorCode}' != "") {
            var mid = '${data.majorCode}';
            var trainingLevel = '${data.trainingLevel}';
            var majorDirection = '${data.majorDirection}';
            $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + mid + "&trainingLevel=" +
                trainingLevel, function (data) {
                addOption(data, 'cid', '${data.classId}');
            });
        } else {
            $("#cid").append("<option value='' selected>请选择</option>")
        }
        table = $("#examStudentTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/student/getExamStudentList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "classId", "visible": false},
                {"data": "studentNumber", "visible": false},
                {"data": "departmentShow", "title": "系部"},
                {"data": "majorShow", "title": "专业"},
                {"data": "classShow", "title": "班级"},
                {"data": "studentName", "title": "学生姓名"},
                {"data": "studentNumber", "title": "学号"},
                {
                    "data": "status", "title": "状态",
                    "render": function (data, type, row) {
                        var status;
                        switch (row.status) {
                            case "0":
                                status = "正常";
                                break;
                            case "1":
                                status = "缓考";
                                break;
                            case "2":
                                status = "超旷";
                                break;
                            case "3":
                                status = "当兵";
                                break;
                        }
                        return status;
                    }
                },
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-trash" title="删除" onclick=delStudent("' + row.id + '","' + row.studentName + '")/>&ensp;&ensp;' +
                            '<span class="icon-edit" title="修改考试状态" onclick=editStatus("' + row.id + '","' + row.status + '")/>&ensp;&ensp;';
                    }
                }
            ],
            'order': [[1, 'desc'], [2, 'desc'], [3, 'desc'], [4, 'desc'], [5, 'desc'], [6, 'desc']],
            "dom": 'rtlip',
            language: language
        });
    });
    function changeMajor() {
        var deptId = $("#did").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'mid');
        });
    }

    function changeClass() {
        var majorCode = $("#mid").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 'cid');
        });
    }
    function editStatus(id, status) {
        $("#examStudentId").val(id);
        $("#status option[value=" + status + "]").attr("selected", "selected");
        $("#modal_default_1").modal("show");
        $(".modal-backdrop").removeClass("modal-backdrop");
    }

    function batchAddExamStudent() {
        var examId = $('#examId').val();
        swal({
            title: "是否按照设定的考试班级批量添加考生?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/student/batchAddExamStudent", {
                examId: examId
            }, function (data) {
                if (data.status == 1) {
                    swal({title: data.msg, type: "error"});
                } else {
                    //$("#layout").css('display','block');
                    swal({title: data.msg, type: "success"});
                    $('#examStudentTable').DataTable().ajax.reload();
                    //$("#layout").css('display','none');
                }
            });
        })

    }

    function editStudent(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/stduent/toEdit?id=" + id)
        $("#dialog").modal("show")
    }


    function delStudent(id, studentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "学生姓名：" + studentName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/stduent/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#examStudentTable').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#stu_name").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?examId=${examId}").load();
    }

    function search() {
        var departmentsId = $("#did").val();
        var majorCode = $("#mid").val();
        if(majorCode == null || majorCode == ""){
            majorCode="";
        }else{
            majorCode =  majorCode.split(",")[0];
        }
        var classId = $("#cid").val();

        /*var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();*/
        var stu_name = $("#stu_name").val();
        var majorData = "";
        var trainingLevel = "";
       /* if (did != undefined || did != null || did == "") {
            table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&examId=${examId}").load();
            if (stu_name != undefined || stu_name != null || stu_name == "") {
                table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&studentName=" + stu_name + "&examId=${examId}").load();
            }
            if (mid != undefined || mid != null || mid == "") {
                majorData = mid.substring(0, 6);
                trainingLevel = mid.substring(7, mid.length);
                table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&majorCode=" + majorData + "&trainingLevel=" + trainingLevel + "&examId=${examId}").load();
                if (stu_name != undefined || stu_name != null || stu_name == "") {
                    table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&majorCode=" + majorData + "&trainingLevel=" + trainingLevel + "&studentName=" + stu_name).load();
                }
            }
            if (cid != undefined) {
                table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&majorCode=" + majorData + "&trainingLevel=" + trainingLevel + "&classId=" + cid + "&examId=${examId}").load();
                if (stu_name != undefined || stu_name != null || stu_name == "") {
                    table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + did + "&majorCode=" + majorData + "&trainingLevel=" + trainingLevel + "&classId=" + cid + "&studentName=" + stu_name + "&examId=${examId}").load();
                }
            }

        }*/
        table.ajax.url("<%=request.getContextPath()%>/exam/student/getExamStudentList?departmentsId=" + departmentsId + "&majorCode=" + majorCode + "&trainingLevel=" + trainingLevel + "&classId=" + classId + "&studentName=" + stu_name + "&examId=${examId}").load();

    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/student");
    }
</script>
<script>


    window.onscroll = function () {
        var box = document.getElementById("layout");
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        box.style.top = 80 + t + "px";
    }
</script>
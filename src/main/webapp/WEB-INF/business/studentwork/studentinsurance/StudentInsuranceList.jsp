<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/28
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                身份证账号：
                            </div>
                            <div class="col-md-2">
                                <input id="idcardSel" type="text"
                                       class="validate[required,maxSize[50]] form-control autoInput"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                       placeholder="请输入身份证号，并点选" value="${stuInsuranceEdit.idcard}"/>

                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                学号：
                            </div>
                            <div class="col-md-2">
                                <input id="studentNumberSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                    <input id="classSel" type="text"
                                           class="validate[required,maxSize[50]] form-control autoInput"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           placeholder="请输入班级，并点选"/>
                                    <input id="classIdSel" hidden>
                            </div>

                            <div class="col-md-1 tar">
                                宿舍号：
                            </div>
                            <div class="col-md-2">
                                    <input id="dormSel" type="text"
                                           class="validate[required,maxSize[50]] form-control autoInput"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                           placeholder="请输入宿舍号，并点选" />
                                    <input id="dormIdSel"  hidden>
                            </div>
                            <div class="col-md-2 tar">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addStudentInsurance()">新增
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importStudentInsuranceTemplate()">下载导入模板
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importStudentInsurance()">导入
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="exportStudentInsurance()">导出
                            </button>
                            <br>
                        </div>
                        <table id="stuInsuranceGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script type="text/javascript">
    // var table;
    $(function () {
        $.get("<%=request.getContextPath()%>/common/getIdCard", function (data) {
            $("#idcardSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#idcardSel").val(ui.item.label);
                    $("#idcardSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
        $.get("<%=request.getContextPath()%>/common/getClassBean", function (data) {
            $("#classSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#classSel").val(ui.item.label);
                    $("#classSel").attr("keycode", ui.item.value);
                    $("#classIdSel").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
        $.get("<%=request.getContextPath()%>/common/getDorm", function (data) {
            $("#dormSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dormSel").val(ui.item.label);
                    $("#dormIdSel").val(ui.item.value);
                    $("#dormSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
        search();

    })

    function del(id){
        swal({
            title: "您确定要删除本条信息?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/studentInsurance/delStudentInsurance",{
                id:id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#stuInsuranceGrid').DataTable().ajax.reload();
                }
            })
        });
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/studentInsurance/editStudentInsuranceList?insuranceType=${insuranceType}&id="+id);
        $("#dialog").modal("show");
    }
    
    function addStudentInsurance() {
        $("#dialog").load("<%=request.getContextPath()%>/studentInsurance/editStudentInsuranceList?insuranceType=${insuranceType}");
        $("#dialog").modal("show");
    }
    function importStudentInsurance() {
        $("#dialog").load("<%=request.getContextPath()%>/studentInsurance/importStudentInsurance?insuranceType=${insuranceType}");
        $("#dialog").modal("show");
    }
    
    function exportStudentInsurance() {
        //export=1为数据导出标识，模板导出没有
        window.location.href = "<%=request.getContextPath()%>/studentInsurance/exportStudentInsurance?insuranceType=${insuranceType}&export=1";
    }
    function importStudentInsuranceTemplate() {
       window.location.href = "<%=request.getContextPath()%>/studentInsurance/exportStudentInsurance?insuranceType=${insuranceType}";
    }

    function search() {

      if ($("#dormSel").val()==""|| undefined == $("#dormSel").val()) {
            $("#dormIdSel").val("");
        }
        if ($("#classSel").val()==""|| undefined == $("#classSel").val()) {
            $("#classIdSel").val("");
        }

        $("#stuInsuranceGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentInsurance/getStudentInsuranceList',
                "data": {
                    insuranceType: '${insuranceType}',
                    studentNumber:$("#studentNumberSel").val(),
                    name:$("#nameSel").val(),
                    idcard:$("#idcardSel").val(),
                    classId:$("#classIdSel").val(),
                    dormId:$("#dormIdSel").val()
                },
                "contentType": "application/x-www-form-urlencoded;charset=UTF-8"
            },
            "destroy": true,
            "columns": [
                // { data: null,width:"5%"},
                {"data":"id","visible": false},
                {"data":"studentId","visible": false},
                {"data": "name", "title": "姓名"},
                {"data": "studentNumber", "title": "学号"},
                {"data": "sexShow", "title": "性别"},
                {"data": "nationShow", "title": "民族"},
                {"data": "birthday", "title": "出生日期"},
                {"data": "idcard", "title": "身份证号"},
                {"data": "classShow", "title": "班级"},
                {"data": "dormName", "title": "宿舍号"},
                {"data": "stuSourceAddr", "title": "生源地"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;';
                    }
                }
            ],
            // 'order': [9, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        })
    }

    function searchClear() {
        $("#studentNumberSel").val("");
        $("#nameSel").val("");
        $("#idcardSel").val("");
        $("#classIdSel").val("");
        $("#classSel").val("");
        $("#dormIdSel").val("");
        $("#dormSel").val("");
        search();
    }

</script>

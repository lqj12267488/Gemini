<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                姓名:
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="name"/>
                            </div>
                            <div class="col-md-1 tar">
                                身份证号:
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="idcard"/>
                            </div>
                            <div class="col-md-1 tar">
                                学年:
                            </div>
                            <div class="col-md-2">
                                <select id="f_year" class="js-example-basic-single">
                                    <c:forEach var="year" items="${allYear}">
                                        <option value="${year}">${year}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                培养模式:
                            </div>
                            <div class="col-md-2">
                                <select id="registerType" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                考生类别:
                            </div>
                            <div class="col-md-2">
                                <select id="examType" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                省:
                            </div>
                            <div class="col-md-2">
                                <select id="province" class="js-example-basic-single"></select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                民族:
                            </div>
                            <div class="col-md-2">
                                <select id="nation" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                语言:
                            </div>
                            <div class="col-md-2">
                                <select id="language" class="js-example-basic-single"></select>
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
                </div>
                <div class="block block-drop-shadow content">
                    <table id="table" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th width="6%">年份</th>
                                <th width="8%">培养模式</th>
                                <th width="8%">姓名</th>
                                <th width="7%">民族</th>
                                <th width="6%">语言</th>
                                <th width="8%">身份证号</th>
                                <th width="9%">生源</th>
                                <th width="9%">考生类别</th>
                                <th width="7%">报名起点</th>
                                <th width="7%">考试成绩</th>
                                <th width="9%">专业</th>
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
    var table;
    var baseUrl = "<%=request.getContextPath()%>";
    $(document).ready(function () {
        //省
        getAdministrativeDivisions("province", $("#province").val(), " and type = '1' ", baseUrl);
        // 民族
        $.get(baseUrl + "/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'nation');
        });
        // 培养模式
        $.get(baseUrl + "/common/getSysDict?name=PYMS", function (data) {
            addOption(data, 'registerType');
        });
        // 语言
        $.get(baseUrl + "/common/getSysDict?name=YY", function (data) {
            addOption(data, 'language');
        });
        // 考生类别
        $.get(baseUrl + "/common/getSysDict?name=XSLB", function (data) {
            addOption(data, 'examType');
        });
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/onlineregister/getOnlineRegisterList',
                "data": {
                    auditFlag:1
                },
            },
            "destroy": true,
            "columns": [
                {"data":"id", "visible": false},
                {"width": "6%", "data":"year","title":"学年"},
                {"width": "8%", "data":"registerTypeShow","title":"培养模式"},
                {"width": "8%", "data":"name","title":"姓名"},
                {"width": "7%", "data":"nation","title":"民族"},
                {"width": "6%", "data":"language","title":"语言"},
                {"width": "8%", "data":"idcard","title":"身份证号"},
                {"width": "9%", "data":"province","title":"生源"},
                {"width": "9%", "data":"examTypeShow","title":"考生类别"},
                {"width": "7%", "data":"registerOriginShow","title":"报名起点"},
                {"width": "7%", "data":"examScore","title":"考试成绩"},
                {"width": "9%", "data":"majorName","title":"专业"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-search" title="查看" onclick=show("' + row.id + '")></span>'
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }

    function searchclear() {
        $("#name").val("");
        $("#idcard").val("");
        $("#f_year").val("${allYear[0]}");
        $("#examType").val("");
        $("#province").val("");
        $("#nation").val("");
        $("#language").val("");
        $("#registerType").val("");
        table.ajax.url(baseUrl + "/onlineregister/getOnlineRegisterList").load();
    }

    function search() {
        var url = "&name="+ $("#name").val() + "&idcard="+ $("#idcard").val() + "&examType="+ $("#examType").val() + "&province="+ $("#province").val() + "&nation="+ $("#nation").val() + "&language="+ $("#language").val()  + "&registerType="+ $("#registerType").val() ;
        table.ajax.url(baseUrl + "/onlineregister/getOnlineRegisterList?" + url).load();
    }

    function show(id) {
        $("#dialog").load(baseUrl + "/onlineregister/toOnlineRegisterEdit?id=" + id);
        $("#dialog").modal("show");
    }

    function internshipUnitObtain() {
        window.location.href = "<%=request.getContextPath()%>/onlineregister/importRegister?type=${type}&origin=${origin}&year=" + $("#f_year").val();
    }
</script>
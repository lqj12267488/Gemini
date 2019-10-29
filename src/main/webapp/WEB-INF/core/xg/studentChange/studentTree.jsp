<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="majorClassTree" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="header">
                            <span id="deptName" style="font-size: 15px;margin-left: 20px">所有人员</span>
                        </div>
                        <div class="content">
                            <table id="studentChangeGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var majorClassTree;
    var studentChangeTable;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
                rootPId:'0'
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function zTreeOnClick(event, treeId, treeNode) {
        if ('${flag}' == '1'){
            studentChangeTable.ajax.url("<%=request.getContextPath()%>/studentChangeLog/getGraduateStudentList?deptId=" + treeNode.id+"&type="+treeNode.type).load();
        } else {
            studentChangeTable.ajax.url("<%=request.getContextPath()%>/studentChangeLog/getStudentList?deptId=" + treeNode.id).load();
        }
    }

    $(document).ready(function () {
        if ('${flag}' == '1') {
            $.get("<%=request.getContextPath()%>/student/getMajorGraduateClassTree", function (data) {
                majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
                majorClassTree.expandAll(true);
            })
        }else {
            $.get("<%=request.getContextPath()%>/student/getMajorClassTree", function (data) {
                majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
                majorClassTree.expandAll(true);
            })
        }


        studentChangeTable = $("#studentChangeGrid").DataTable({
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "15%", "data": "name", "title": "学生姓名"},
                {"width": "15%","data": "userAccount", "title": "登录账号"},
                {"width": "15%", "data": "sexShow", "title": "性别"},
                {"width": "20%", "data": "idcard", "title": "身份证号"},
                {"width": "15%", "data": "birthday", "title": "出生日期"},
                {"width": "15%", "data": "studentStatusShow", "title": "学籍状态"},
                {
                    "width": "5%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='changeClass' title='班级异动' class='icon-sitemap'></a>&ensp;&ensp;" +
                                 "<a id='changeStatus' title='状态异动' class='icon-edit'></a>&ensp;&ensp;" +
                                 "<a id='searchLog' title='查看异动日志' class='icon-search'></a> " ;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        studentChangeTable.on('click', 'tr a', function () {
            var data = studentChangeTable.row($(this).parent()).data();
            var studentId = data.studentId;
            if (this.id == "changeClass") {
                $("#dialog").load("<%=request.getContextPath()%>/studentChangeLog/studentChangeClassTree?studentId=" + studentId);
                $("#dialog").modal("show");
            }
            if (this.id == "changeStatus") {
                $("#dialog").load("<%=request.getContextPath()%>/studentChangeLog/studentStatus?studentId=" + studentId+"&name="+data.name);
                $("#dialog").modal("show");
            }
            if (this.id == "searchLog") {
                $("#dialog").load("<%=request.getContextPath()%>/studentChangeLog/logByStudent?studentId=" + studentId);
                $("#dialog").modal("show");
            }
        });

    });

</script>
<style>
    #style-4::-webkit-scrollbar-track
    {
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar
    {
        width: 5px;
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar-thumb
    {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>
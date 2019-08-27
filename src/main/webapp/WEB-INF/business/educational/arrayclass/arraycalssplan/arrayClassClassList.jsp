<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${arrayClassName} > 维护班级教学计划</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayclass/getArrayClassClassList?arrayclassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "className", "title": "班级名称"},
                {"data": "departmentsId", "title": "系部名称"},
                {"data": "majorCode", "title": "专业名称"},
                {"data": "roomId", "title": "教室名称"},
                {"data": "studentNumber", "title": "班级学生数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="设置教学计划" onclick=set("' + row.arrayclassClassId + '","' + row.classId + '","'+row.className+'")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function set(id, classId, className) {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toArrayclassArrayList?id=${arrayClassId}&classId=" + classId + "&arrayclassClassId=" + id + "&className="+className+"&arrayClassName=${arrayClassName}" );
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayclassplan/toArrayClass");
    }
</script>
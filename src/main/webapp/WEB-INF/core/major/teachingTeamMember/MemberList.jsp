<%--
  Description: 
  Creator: 郭千恺
  Date: 2018/10/11 10:03
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                            <button type="button" class="btn btn-default btn-clean" onclick="add()">新增</button>
                        </div>
                        <div class="form-row">

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
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/suggestionBox/student/manage/getReplyList?id=' + '${suggestion.id}'
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "replierName", "title": "回复人"},
                {"data": "deptName", "title": "所属部门"},
                {"data": "reply", "title": "回复"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-zoom-in" title="详情" onclick=detail("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';
                    }
                }
            ],
            'order' : [0,'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
    <!-- 删除 -->
    function del(id) {alert('删除')
        <%--$.post("<%=request.getContextPath()%>/suggestionBox/student/manage/delReply", {--%>
            <%--id: id--%>
        <%--}, function (success) {--%>
            <%--if (success) {--%>
                <%--successMessage("删除成功!");--%>
                <%--$('#table').DataTable().ajax.reload();--%>
            <%--} else {--%>
                <%--errorMessage("删除失败!");--%>
            <%--}--%>
        <%--});--%>
    }
    <!-- 返回上级 -->
    function back() {alert('返回')
        <%--$("#right").load("<%=request.getContextPath()%>/suggestionBox/student/manage/suggestionListPage");--%>
    }
    <!-- 回复 -->
    function add() {alert('新增')
        <%--$("#dialog").load("<%=request.getContextPath()%>/suggestionBox/student/manage/saveReply?suggestionId=${suggestion.id}");--%>
        <%--$("#dialog").modal("show");--%>
    }
</script>
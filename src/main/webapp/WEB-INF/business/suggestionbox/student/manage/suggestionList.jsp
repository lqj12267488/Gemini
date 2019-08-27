<%--

  Date: 2018/9/26 16:00
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">主题:</div>
                            <div class="col-md-2">
                                <input id="searchTitle" onkeyup="keyup_submit()"/>
                            </div>
                            <div class="col-md-1 tar">状态:</div>
                            <div class="col-md-2">
                                <select id="replyFlag" onchange="search()"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="clearSearch()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
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
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YJHFZT", function (data) {
            addOption(data, "replyFlag", "1");
        });

        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/suggestionBox/student/manage/getSuggestionList'
            },
            "destroy": true,
            "columns": [
                {"data": "title",           "title": "主题"},
                {"data": "majorSchoolShow", "title": "所属学院"},
                {"data": "majorCodeShow",       "title": "专业"},
                {"data": "classShow",       "title": "班级"},
                {"data": "studentName",     "title": "学生姓名"},
                {"data": "suggestDate",     "title": "提出时间"},
                {"data": "replyFlagShow",   "title": "状态"},
                {"data": "suggestion",      "title": "内容"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-zoom-in" title="查看详情" onclick=detail("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-comment-alt" title="回复列表" onclick=reply("' + row.id + '")/>';
                    }
                }
            ],
            'order' : [5, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
    <!-- 查询 -->
    function search() {
        var searchTitle = $("#searchTitle").val();
        var searchReplyFlag = $('#replyFlag').val();
        var url = '<%=request.getContextPath()%>/suggestionBox/student/manage/getSuggestionList?title=' + searchTitle + '&replyFlag=' + searchReplyFlag;
        $("#table").DataTable().ajax.url(url).load();
    }

    <!-- 清空查询 -->
    function clearSearch() {
        $("#searchTitle").val('');
        search();
    }
    <!-- 查看意见详情 -->
    function detail(id) {
        $("#dialog").load("<%=request.getContextPath()%>/suggestionBox/student/manage/suggestionDetail?id=" + id);
        $("#dialog").modal("show");
    }
    <!-- 回复意见(进入回复列表) -->
    function reply(id) {
        $("#right").load("<%=request.getContextPath()%>/suggestionBox/student/manage/replyListPage?id=" +id);
    }
    <!-- 忽略意见 -->
    function notReply(id) {
        $.get("<%=request.getContextPath()%>/suggestionBox/student/manage/notReply?id=" + id, function (success) {
            if (success) {
                successMessage("已忽略!")
                search();
            } else {
                errorMessage("操作失败!");
            }
        });
    }
    <!-- 文本搜索框回车查询 -->
    function keyup_submit(e) {
        var evt = window.event || e;
        if (evt.keyCode == 13){
           search();
        }
    }

    <!-- 提示*3 -->
    function infoMessage(msg, type) {
        swal({
            title: msg,
            type: type || "info"
        });
    }
    function successMessage(msg, type) {
        swal({
            title: msg,
            type: type || "success"
        });
    }
    function errorMessage(msg, type) {
        swal({
            title: msg,
            type: type || "error"
        });
    }
</script>

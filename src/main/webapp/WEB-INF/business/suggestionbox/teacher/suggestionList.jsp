<%--
  Description: 意见箱--教师--意见列表
  Creator: 郭千恺
  Date: 2018/9/27 9:48
--%>
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
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="add()">新的意见
                            </button>
                            <br>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YJHFZT", function (data) {
            addOption(data, "replyFlag");
        });
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/suggestionBox/teacher/getSuggestionList'
            },
            "destroy": true,
            "columns": [
                {"data": "title",           "title": "主题"},
                {"data": "replyFlagShow",   "title": "状态"},
                {"data": "suggestion",      "title": "内容"},
                {"data": "suggestDate",     "title": "提出时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        if(row.viewFlag == 0) {
                            return '<span class="icon-zoom-in" title="详情" onclick=detail("' + row.id + '")/>&ensp;&ensp;' +
                                '<span class="icon-comment-alt" title="回复" onclick=replyList("' + row.id + '")/>&ensp;&ensp;'+
                                '<span id="del" class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';
                        }else {
                            return '<span class="icon-zoom-in" title="详情" onclick=detail("' + row.id + '")/>&ensp;&ensp;' +
                                '<span class="icon-comment-alt" title="回复" onclick=replyList("' + row.id + '")/>&ensp;&ensp;';

                        }
                    }
                }
            ],
            'order' : [3, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    });
    <!-- 新增意见 -->
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/suggestionBox/teacher/addSuggestion");
        $("#dialog").modal("show");
    }
    <!-- 查询 -->
    function search() {
        var searchTitle = $("#searchTitle").val();
        var searchReplyFlag = $('#replyFlag').val();
        var url = '<%=request.getContextPath()%>/suggestionBox/teacher/getSuggestionList?title=' + searchTitle + '&replyFlag=' + searchReplyFlag;
        $("#table").DataTable().ajax.url(url).load();
    }
    <!-- 清空查询 -->
    function clearSearch() {
        $("#searchTitle").val('');
        $("#replyFlag").val('');
        search();
    }
    <!-- 文本搜索框回车查询 -->
    function keyup_submit(e) {
        var evt = window.event || e;
        if (evt.keyCode == 13){
            search();
        }
    }
    <!-- 意见详情 -->
    function detail(id) {
        $("#dialog").load("<%=request.getContextPath()%>/suggestionBox/teacher/suggestionDetail?id=" + id);
        $("#dialog").modal("show");
        $("#table").DataTable().ajax.reload();
    }
    function del(id) {
        //if (confirm("请确认是否要删除本条业务关联?")) {
        swal({
            title: "您确定要删除本条信息?",
            //text: "关联业务："+data.text+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/suggestionBox/teacher/suggestionDel?id=" + id, function (msg) {

                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $('#table').DataTable().ajax.reload();

            })
        })
    }
    <!-- 回复列表 -->
    function replyList(id) {
        $("#right").load("<%=request.getContextPath()%>/suggestionBox/teacher/getReplyListPage?id=" +id);
    }
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
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
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/crawler/content/getContentList',
            },
            "destroy": true,
            "columns": [
                {
                    "title": "url",
                    "render": function (data, type, row) {
                        return "<a href='" + row.url + "' target='_blank' title='" + row.url + "'>" +
                            row.url.substring(8, 30) + "</a>"
                    }
                },
                {
                    "title": "摘要",
                    "render": function (data, type, row) {
                        return "<span title='" + row.title + "'>" + row.title.substring(0, 15) + "</span>"
                    }
                },
                {"data": "channelName", "title": "网站栏目"},
                {"data": "webId", "title": "网站名称"},
                {"data": "sensiWords", "title": "敏感词"},
                {"data": "sensiLevel", "title": "敏感词级别"},
                {"data": "grabDate", "title": "爬取时间"},
            ],
            "dom": 'rtlip',
            language: language
        });
    })
</script>
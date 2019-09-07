<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2018/1/25
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="/libs/js/plugins/ssi-uploader/css/ssi-uploader.css">
<script src="/libs/js/plugins/ssi-uploader/js/ssi-uploader.js"></script>
<div class="modal-dialog" style="min-width: 1200px;">
    <div class="modal-content block-fill-white" id="leftView">
        <div class="modal-header">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <table id="filesTables" cellpadding="0" cellspacing="0" width="100%" style=" max-height: 50%;min-height: 10%;"
                   class="table table-bordered table-striped sortable_default">
                <thead>
                    <tr role="row">
                        <th tabindex="0" aria-controls="filesTables" rowspan="1" colspan="1"
                            aria-label="文件名称: 以降序排列此列" style="width: 448px;" aria-sort="ascending">文件名称
                        </th>
                        <th tabindex="0" aria-controls="filesTables" rowspan="1" colspan="1"
                            aria-label="操作: 以升序排列此列" style="width: 57px;">操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items='${files.split(",")}' var="file" varStatus="status">
                    <tr role="row" class='${status.count%2==0?"odd":"even"}'>
                        <td class="sorting_1">
                            <span id="preview" title="点击预览" onclick="preview('${file}')">${file}</span>
                        </td>
                        <td>
                            <a id="upload" href="/onlineregister/downloadFile?id=${id}&url=${file}" class="icon-download" title="下载"></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="file" style="display: none;">
                <input id="ssi-uploads" type="file" multiple/>
            </div>
        </div>
    </div>
    <div id="rightView"></div>
</div>
<style>
    #leftView {
        position: relative;
    }

    #leftView, #rightView {
        float: left;
        width: 580px;
    }

    #rightView .modal-dialog {
        padding: 0px;
    }
</style>

<script>
    function preview(file) {
        $("#rightView").load("<%=request.getContextPath()%>/onlineregister/getPreview?id=${id}&file=" + file);
        $("#rightView").modal("show");
    }
</script>

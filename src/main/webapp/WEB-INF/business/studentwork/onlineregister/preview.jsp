<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div id="md">
        <div class="modal-header">
            <span style="font-size: 14px;color:#FFF">文件预览</span>
            <button type="button" class="close" onclick="closeView()" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div id="rView" ></div>
        </div>
    </div>
</div>
<script>
    var fileFormat = '${fileFormat}';
    $(document).ready(function () {
        var cjhtml = "";
        if (fileFormat == 1 || fileFormat == 9) {
            cjhtml = '<iframe frameborder="0" marginheight="0" class="media"' +
                ' style="position:absolute;overflow-y:auto!important; height:760px;width:96.8%;"' +
                '  marginwidth="0" scrolling="no" src="<%=request.getContextPath()%>/libs/js/resourcelibrary/generic/web/viewer.html?file=${fileView}"></iframe>';
        } else if (fileFormat == 2) {
            cjhtml = '<img style="max-width:100%;max-height:100%" src="<%=request.getContextPath()%>${fileView}">';
        } else if (fileFormat == 3) {
            cjhtml = '<div id = audi style="text-align: center">' +
                '<img style=";width:150px;height:150px" src="<%=request.getContextPath()%>/libs/img/webuploader/speaker.png">' +
                '<audio src="<%=request.getContextPath()%>${fileView}" style="width:78% ;" controls="controls"></audio></div>';
        } else if (fileFormat == 4) {
            cjhtml = '<video id="example_video_1" class="video-js" controls preload="auto" style="width:100%; max-height: 500px;" data-setup="{}">' +
                '<source src="<%=request.getContextPath()%>${fileView}" type="video/mp4" />' +
                '<track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track>' +
                '<track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track>' +
                '</video>';
        } else{
            cjhtml = '<div style="height: 400px ;font-size:18px;text-align: center;line-height: 400px;">该文件类型不支持预览</div>'
        }
        cjhtml = '<div>' + cjhtml + '</div>';
        $("#rView").html(cjhtml);
    })
    function closeView() {
        $("#rightView").modal("hide");
    }
</script>
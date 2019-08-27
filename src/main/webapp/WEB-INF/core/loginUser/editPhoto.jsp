<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/5/4
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">上传头像</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-12 ">
                        <%--<img src="../libs/img/example/user/dmitry_b.jpg"  height="200" width="200"
                             class="img-circle img-thumbnail" id="imgSrc"/>--%>
                        <div class="info">
                            <div class="form-group">
                                <div id="pre" height="200" width="200">
                                    <input id="urlValue" hidden value="../userImg/${url}">
                                    <img src="<%=request.getContextPath()%>/userImg/${url}" id="photoUrl" height="200" width="200"
                                         class="img-circle img-thumbnail"/>
                                </div>
                                <div id="preview" style="display: none" height="200" width="200">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-10">
                                    <form action="<%=request.getContextPath()%>/loginuser/savePhoto?EmppersonId=${personid}"
                                          enctype="multipart/form-data" id="importPhoto" target="nm_iframe"
                                          method="post">
                                        <input type="file" name="file" id="fileImg" width="100%"
                                               onchange="fileChange(this);"
                                               accept="image/jpg,image/jpeg,image/gif,image/png,image/bmp"/>
                                        <input id="EmppersonId" hidden value="${personid}">
                                        <%--<button style="display: none" class="btn btn-info btn-clean" id="imPhoto"
                                                    type="submit">导入</button>--%>
                                    </form>
                                </div>
                                <div class="col-md-2">
                                    <iframe id="id_iframe" name="nm_iframe" style="display:none;"></iframe>
                                    <button class="btn btn-info btn-clean" onclick="importP()">上传</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    function importP() {
        console.log($("#fileImg"))
        if ($("#fileImg").val() == "") {
            swal({
                title: "请选择文件！",
            });
            $("#pre").css('display', 'block');
            $("#preview").css('display', 'none');
            return;
        }
        var nametype = $("#fileImg").val().split('.');
        var type = nametype[1].toLowerCase();
        if (!(type == "jpg" || type == "jpeg" || type == "gif" || type == "png" || type == "png" )) {
            //image/jpg,image/jpeg,image/gif,image/png,image/png
            swal({
                title: "请选择格式为jpg/jpeg/gif/png/png的图片！",
            });
//            alert("请选择格式为jpg/jpeg/gif/png/png的图片！");
            return;
        } else {
            var form = new FormData(document.getElementById("importPhoto"));
            $.ajax({
                url: '<%=request.getContextPath()%>/loginuser/savePhoto?EmppersonId=' + $("#EmppersonId").val(),
                type: "post",
                data: form,
                processData: false,
                contentType: false,
                success: function (data) {
                    swal({
                        title: data.msg
                    });
                    //alert(data.msg);
                    if (data.status == 1)
                        closeDialog();
                }
            });
        }
    }

    function closeDialog() {
        $("#dialog").modal('hide');
        window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";
    }

    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;

    function fileChange(target) {
        var filePath = target.value; // 获得上传文件的绝对路径
        var fileSize = 0;

        if (filePath == "") {
            $("#fileImg").val("");
            $("#pre").css('display', 'block');
            $("#preview").css('display', 'none');
            $("#photoUrl").css('src', $("#urlValue").val());
            return;
        }

        if (isIE && !target.files) {    // IE浏览器
            /**
             * ActiveXObject 对象为IE和Opera所兼容的JS对象
             * 用法：
             *         var newObj = new ActiveXObject( servername.typename[, location])
             *         其中newObj是必选项。返回 ActiveXObject对象 的变量名。
             *        servername是必选项。提供该对象的应用程序的名称。
             *        typename是必选项。要创建的对象的类型或类。
             *        location是可选项。创建该对象的网络服务器的名称。
             *\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
             *     Scripting.FileSystemObject 为 IIS 内置组件，用于操作磁盘、文件夹或文本文件，
             *    其中返回的 newObj 方法和属性非常的多
             *    如：var file = newObj.CreateTextFile("C:\test.txt", true) 第二个参表示目标文件存在时是否覆盖
             *    file.Write("写入内容");    file.Close();
             */
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            // GetFile(path) 方法从磁盘获取一个文件并返回。
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;    // 文件大小，单位：b
        }
        else {    // 非IE浏览器
            fileSize = target.files[0].size;
        }
        var size = fileSize / 1024;
        if (size > 1024) {
            swal({
                title: "附件不能大于1M",
            });
            //alert("附件不能大于1M");
            $("#fileImg").val("");
            $("#pre").css('display', 'block');
            $("#preview").css('display', 'none');
        } else {
            $("#pre").css('display', 'none');
            $("#preview").css('display', 'block');
            setFile(target);
        }
    }

    function setFile(file) {
        var div = document.getElementById('preview');
        if (file.files && file.files[0]) {
            div.innerHTML = '<img id=imghead>';
            var img = document.getElementById('imghead');
            img.onload = function () {
                img.width = 200;
                img.height = 200;
                img.style.marginTop = '0px';
            }
            var reader = new FileReader();
            reader.onload = function (evt) {
                img.src = evt.target.result;
            }
            reader.readAsDataURL(file.files[0]);
            img.className = "img-circle img-thumbnail";
        } else { //兼容IE
            var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
            file.select();
            var src = document.selection.createRange().text;
            div.innerHTML = '<img id=imghead>';
            var img = document.getElementById('imghead');
            img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
            div.innerHTML = "<div class='img-circle img-thumbnail' id='divhead' style='width:" + rect.width + "px;height:200px;margin-top:0px;" + sFilter + src + "\"'></div>";
        }
    }

</script>
<style>
    .talign {
        text-align: left
    }

    .styleRed {
        color: red !important;
    }
</style>
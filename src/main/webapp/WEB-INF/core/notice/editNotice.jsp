<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/ueditor/lang/zh-cn/zh-cn.js"></script>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        标题
                    </div>
                    <div class="col-md-10">
                        <input id="title" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control" value="${notice.title}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        类型
                    </div>
                    <div class="col-md-4">
                        <select id="type"/>
                    </div>
                    <%--<div class="col-md-2">
                        发布时间
                    </div>
                    <div class="col-md-4">
                        <input id="publicTime" type="date"
                               class="validate[required,maxSize[20]] form-control" value="${notice.publicTime}"/>
                    </div>--%>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-2 tar">
                        开始时间
                    </div>
                    <div class="col-md-4">
                        <input id="startTime" type="date"
                               class="validate[required,maxSize[20]] form-control" value="${notice.startTime}"/>
                    </div>
                    <div class="col-md-2 tar">
                        结束时间
                    </div>
                    <div class="col-md-4">
                        <input id="endTime" type="date"
                               class="validate[required,maxSize[20]] form-control" value="${notice.endTime}"/>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>
                        内容
                    </div>
                    <div class="col-md-10 tar">
                        <div id="editor" style="width:100%;height:500px;"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveNotice()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="id" hidden value="${notice.id}">
<input id="workflag" hidden value="${workflag}">
<input id="isDean" hidden value="${isDean}">
<script>


    var ue;
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "type", "${notice.type}");
        })
        ue = UE.getEditor('editor');
        $(".modal-dialog").width("50%")
    });

    function saveNotice() {
        var title = $("#title").val();
        var type = $("#type option:selected").val();
        //var publicTime = $ ("# publicTime").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var content = UE.getEditor('editor').getContent();
        if (!title == '' || !title == undefined || !title == null) {
            if (title.indexOf(" ") != -1 || title.indexOf("/") != -1 || title.indexOf("@") != -1) {
                swal({title: "标题中不可包含特殊符号。例如[空格]、[/]、[@]等！", type: "info"});
                return;
            }

        } else {
            swal({title: "请填写标题！", type: "info"});
            return;
        }
        if (type == '' || type == undefined || type == null) {
            swal({title: "请选择类型！", type: "info"});
            return;
        }

        /*if (publicTime == '' || publicTime == undefined || publicTime == null) {
            alert("请选择发布时间！");
            return;
        }*/
        /*if (startTime == '' || startTime == undefined || startTime == null) {
            alert("请选择开始时间！");
            return;
        }
        if (endTime == '' || endTime == undefined || endTime == null) {
            alert("请选择结束时间！");
            return;
        }
        if( startTime > endTime){
            swal({title: "请选择开始时间需要在结束时间之前！",type: "info"});
            return;
        }
        if (content == '' || content == undefined || content == null) {
            swal({title: "请编辑内容！",type: "info"});
            return;
        }
        */
        $.post("<%=request.getContextPath()%>/saveNotice", {
            id: $("#id").val(),
            title: title,
            type: type,
            content: content,
            workFlowFlag: $("#workflag").val(),
            isDean: $("#isDean").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal("hide");
                noticeTable.ajax.reload();
            }
        })
        showSaveLoading();
    }

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例


    function isFocus(e) {
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }

    function setblur(e) {
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }

    function insertHtml(value) {
        UE.getEditor('editor').execCommand('insertHtml', value)
    }

    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }

    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }

    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }

    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }

    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        alert(arr.join("\n"));
    }

    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }

    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }

    function setFocus() {
        UE.getEditor('editor').focus();
    }

    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }

    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }

    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData() {
        alert(UE.getEditor('editor').execCommand("getlocaldata"));
    }

    function clearLocalData() {
        UE.getEditor('editor').execCommand("clearlocaldata");
        alert("已清空草稿箱")
    }

    ue.addListener("ready", function () {
        var html = '${notice.content}';
        ue.setContent(html)
    });
</script>
<style>
    #edui_fixedlayer {
        z-index: 1060 !important;
    }

    modal-dialog {
        width: 1000px !important;
    }
    .edui-default{
        color:black;
    }
</style>
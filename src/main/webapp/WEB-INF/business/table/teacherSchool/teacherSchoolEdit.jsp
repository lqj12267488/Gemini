<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教职工
                    </div>
                    <div class="col-md-9">
                        <input id="personidEdit" value="${data.person}"/>
                        <input id="perId" type="hidden" value="${data.person}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否主持
                    </div>
                    <div class="col-md-9">
                        <%--<input id="whetherhostEdit" value="${data.whetherhost}"/>--%>
                        <select id="whetherhostEdit">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>技术专利(发明)编号
                    </div>
                    <div class="col-md-9">
                        <input id="inventnumberEdit" value="${data.inventnumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课题性质
                    </div>
                    <div class="col-md-9">
                        <%--<input id="topicnatureEdit" value="${data.topicnature}"/>--%>
                        <select id="topicnatureEdit">
                            <option value="教学改革">教学改革</option>
                            <option value="技术开发">技术开发</option>
                            <option value="其他">其他</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课题分类
                    </div>
                    <div class="col-md-9">
                        <input id="subjectclassificationEdit" value="${data.subjectclassification}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课题名称
                    </div>
                    <div class="col-md-9">
                        <input id="subjectnameEdit" value="${data.subjectname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否横向课题
                    </div>
                    <div class="col-md-9">
                       <%-- <input id="horizontaltopicEdit" value="${data.horizontaltopic}"/>--%>
                        <select id="horizontaltopicEdit">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课题级别
                    </div>
                    <div class="col-md-9">
                        <%--<input id="subjectgradeEdit" value="${data.subjectgrade}"/>--%>
                        <select id="subjectgradeEdit">
                            <option value="国家级">国家级</option>
                            <option value="省级">省级</option>
                            <option value="地市级">地市级</option>
                            <option value="校级">校级</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>立项日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="projectdateEdit" value="${data.projectdateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>经费来源
                    </div>
                    <div class="col-md-9">
                        <input id="sourceoffundingEdit" value="${data.sourceoffunding}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>到款金额 
                    </div>
                    <div class="col-md-9">
                        <input id="moneyEdit" value="${data.money}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>完成人顺序 
                    </div>
                    <div class="col-md-9">
                        <%--<input id="completororderEdit" value="${data.completororder}"/>--%>
                        <select id="completororderEdit">
                            <option value="第一">第一</option>
                            <option value="第二">第二</option>
                            <option value="第三">第三 </option>
                            <option value="第四">第四</option>
                            <option value="第五">第五</option>
                            <option value="以后">以后</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>著作与论文分类 
                    </div>
                    <div class="col-md-9">
                        <%--<input id="classificationEdit" value="${data.classification}"/>--%>
                        <select id="classificationEdit">
                            <option value="自然科学与技术">自然科学与技术</option>
                            <option value="人文与社会科学">人文与社会科学</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>作者顺序 
                    </div>
                    <div class="col-md-9">
                        <%--<input id="authororderEdit" value="${data.authororder}"/>--%>
                        <select id="authororderEdit">
                            <option value="独立">独立</option>
                            <option value="第一">第一</option>
                            <option value="第二">第二</option>
                            <option value="第三">第三</option>
                            <option value="第四">第四</option>
                            <option value="以后">以后</option>
                        </select>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#whetherhostEdit").val("${data.whetherhost}");
        $("#topicnatureEdit").val("${data.topicnature}");
        $("#horizontaltopicEdit").val("${data.horizontaltopic}");
        $("#subjectgradeEdit").val("${data.subjectgrade}");
        $("#completororderEdit").val("${data.completororder}");
        $("#classificationEdit").val("${data.classification}");
        $("#authororderEdit").val("${data.authororder}");


        //部门多选树，初始化
        $.get("<%=request.getContextPath()%>/getDeptTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                node = editRangezTree.getNodeByParam("id", lis[i], null);
                var callbackFlag = $("#" + lis[i]).attr("checked");
                editRangezTree.checkNode(node, true, false, callbackFlag);
            }
        });

        //经办人自动提示框
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#personidEdit").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#personidEdit").val(ui.item.label.split("  ----  ")[0]);
                    $("#personidEdit").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    });

    function save() {
        if ($("#personidEdit").val() == "" || $("#personidEdit").val() == undefined || $("#personidEdit").val() == null) {
            swal({
                title: "请填写教职工id！",
                type: "warning"
            });
            return;
        }
        if ($("#whetherhostEdit").val() == "" || $("#whetherhostEdit").val() == undefined || $("#whetherhostEdit").val() == null) {
            swal({
                title: "请填写是否主持 1是0否！",
                type: "warning"
            });
            return;
        }
        if ($("#inventnumberEdit").val() == "" || $("#inventnumberEdit").val() == undefined || $("#inventnumberEdit").val() == null) {
            swal({
                title: "请填写技术专利(发明)编号！",
                type: "warning"
            });
            return;
        }
        if ($("#topicnatureEdit").val() == "" || $("#topicnatureEdit").val() == undefined || $("#topicnatureEdit").val() == null) {
            swal({
                title: "请填写课题性质！",
                type: "warning"
            });
            return;
        }
        if ($("#subjectclassificationEdit").val() == "" || $("#subjectclassificationEdit").val() == undefined || $("#subjectclassificationEdit").val() == null) {
            swal({
                title: "请填写课题分类！",
                type: "warning"
            });
            return;
        }
        if ($("#subjectnameEdit").val() == "" || $("#subjectnameEdit").val() == undefined || $("#subjectnameEdit").val() == null) {
            swal({
                title: "请填写课题名称！",
                type: "warning"
            });
            return;
        }
        if ($("#horizontaltopicEdit").val() == "" || $("#horizontaltopicEdit").val() == undefined || $("#horizontaltopicEdit").val() == null) {
            swal({
                title: "请填写是否横向课题 1是0否！",
                type: "warning"
            });
            return;
        }
        if ($("#subjectgradeEdit").val() == "" || $("#subjectgradeEdit").val() == undefined || $("#subjectgradeEdit").val() == null) {
            swal({
                title: "请填写课题级别！",
                type: "warning"
            });
            return;
        }
        if ($("#projectdateEdit").val() == "" || $("#projectdateEdit").val() == undefined || $("#projectdateEdit").val() == null) {
            swal({
                title: "请填写立项日期！",
                type: "warning"
            });
            return;
        }
        if ($("#sourceoffundingEdit").val() == "" || $("#sourceoffundingEdit").val() == undefined || $("#sourceoffundingEdit").val() == null) {
            swal({
                title: "请填写经费来源！",
                type: "warning"
            });
            return;
        }
        if ($("#moneyEdit").val() == "" || $("#moneyEdit").val() == undefined || $("#moneyEdit").val() == null) {
            swal({
                title: "请填写到款金额 ！",
                type: "warning"
            });
            return;
        }
        if ($("#completororderEdit").val() == "" || $("#completororderEdit").val() == undefined || $("#completororderEdit").val() == null) {
            swal({
                title: "请填写完成人顺序 ！",
                type: "warning"
            });
            return;
        }
        if ($("#classificationEdit").val() == "" || $("#classificationEdit").val() == undefined || $("#classificationEdit").val() == null) {
            swal({
                title: "请填写著作与论文分类 ！",
                type: "warning"
            });
            return;
        }
        if ($("#authororderEdit").val() == "" || $("#authororderEdit").val() == undefined || $("#authororderEdit").val() == null) {
            swal({
                title: "请填写作者顺序 ！",
                type: "warning"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/TeacherSchool/saveTeacherSchool", {
            id: "${data.id}",
            personid: $("#personidEdit").val(),
            personidvalue: $("#perId").val().split(",")[1],
            whetherhost: $("#whetherhostEdit").val(),
            inventnumber: $("#inventnumberEdit").val(),
            topicnature: $("#topicnatureEdit").val(),
            subjectclassification: $("#subjectclassificationEdit").val(),
            subjectname: $("#subjectnameEdit").val(),
            horizontaltopic: $("#horizontaltopicEdit").val(),
            subjectgrade: $("#subjectgradeEdit").val(),
            projectdate: $("#projectdateEdit").val(),
            sourceoffunding: $("#sourceoffundingEdit").val(),
            money: $("#moneyEdit").val(),
            completororder: $("#completororderEdit").val(),
            classification: $("#classificationEdit").val(),
            authororder: $("#authororderEdit").val(),
            type: '1',
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>




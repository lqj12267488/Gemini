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
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-9">
                        <input id="personidEdit" value="${data.person}"/>
                        <input id="perId" type="hidden" value="${data.person}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>等级
                    </div>
                    <div class="col-md-9">
                        <select id="gradeEdit" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>名称
                    </div>
                    <div class="col-md-9">
                        <input id="givennameEdit" value="${data.givenname}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>发证单位
                    </div>
                    <div class="col-md-9">
                        <input id="issuerEdit" value="${data.issuer}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获取日期
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="getdateEdit" value="${data.getDateStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课题性质
                    </div>
                    <div class="col-md-9">
                        <input id="topicnatureEdit" value="${data.topicnature}"/>
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
                        <%--<input id="horizontaltopicEdit" value="${data.horizontaltopic}"/>--%>
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
                        <input id="subjectgradeEdit" value="${data.subjectgrade}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>立项日期
                    </div>
                    <div class="col-md-9">
                        <input id="projectdateEdit" type="date" value="${data.projectDateStr}"/>
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
                        <span class="iconBtx">*</span>完成人顺序 
                    </div>
                    <div class="col-md-9">
                        <input id="completororderEdit" value="${data.completororder}"/>
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
                        <span class="iconBtx">*</span>数量 
                    </div>
                    <div class="col-md-9">
                        <input id="numEdit" value="${data.num}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>最高等级 
                    </div>
                    <div class="col-md-9">
                        <input id="highestgradeEdit" value="${data.highestgrade}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>合作情况 
                    </div>
                    <div class="col-md-9">
                        <input id="cooperationEdit" value="${data.cooperation}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业领域 
                    </div>
                    <div class="col-md-9">
                        <input id="expertiseEdit" value="${data.expertise}"/>
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

        $("#horizontaltopicEdit").val(${data.horizontaltopic})

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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYDJ", function (data) {
            addOption(data, 'gradeEdit', '${data.grade}');
        });
    });

    function save() {
        if ($("#personidEdit").val() == "" || $("#personidEdit").val() == undefined || $("#personidEdit").val() == null) {
            swal({
                title: "请填写教职工！",
                type: "warning"
            });
            return;
        }
        if ($("#gradeEdit").val() == "" || $("#gradeEdit").val() == undefined || $("#gradeEdit").val() == null) {
            swal({
                title: "请填写等级！",
                type: "warning"
            });
            return;
        }
        if ($("#givennameEdit").val() == "" || $("#givennameEdit").val() == undefined || $("#givennameEdit").val() == null) {
            swal({
                title: "请填写名称！",
                type: "warning"
            });
            return;
        }
        if ($("#issuerEdit").val() == "" || $("#issuerEdit").val() == undefined || $("#issuerEdit").val() == null) {
            swal({
                title: "请填写发证单位！",
                type: "warning"
            });
            return;
        }
        if ($("#getdateEdit").val() == "" || $("#getdateEdit").val() == undefined || $("#getdateEdit").val() == null) {
            swal({
                title: "请填写获取日期！",
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
                title: "请填写是否横向课题  1是  0否！",
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
        if ($("#completororderEdit").val() == "" || $("#completororderEdit").val() == undefined || $("#completororderEdit").val() == null) {
            swal({
                title: "请填写完成人顺序 ！",
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
        if ($("#numEdit").val() == "" || $("#numEdit").val() == undefined || $("#numEdit").val() == null) {
            swal({
                title: "请填写数量 ！",
                type: "warning"
            });
            return;
        }
        if ($("#highestgradeEdit").val() == "" || $("#highestgradeEdit").val() == undefined || $("#highestgradeEdit").val() == null) {
            swal({
                title: "请填写最高等级 ！",
                type: "warning"
            });
            return;
        }
        if ($("#cooperationEdit").val() == "" || $("#cooperationEdit").val() == undefined || $("#cooperationEdit").val() == null) {
            swal({
                title: "请填写合作情况 ！",
                type: "warning"
            });
            return;
        }
        if ($("#expertiseEdit").val() == "" || $("#expertiseEdit").val() == undefined || $("#expertiseEdit").val() == null) {
            swal({
                title: "请填写专业领域 ！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/Research/saveResearch", {
            id: "${data.id}",
            personid: $("#personidEdit").val(),
            personidvalue: $("#perId").val().split(",")[1],
            grade: $("#gradeEdit").val(),
            givenname: $("#givennameEdit").val(),
            issuer: $("#issuerEdit").val(),
            getdate: $("#getdateEdit").val(),
            topicnature: $("#topicnatureEdit").val(),
            subjectclassification: $("#subjectclassificationEdit").val(),
            subjectname: $("#subjectnameEdit").val(),
            horizontaltopic: $("#horizontaltopicEdit").val(),
            subjectgrade: $("#subjectgradeEdit").val(),
            projectdate: $("#projectdateEdit").val(),
            sourceoffunding: $("#sourceoffundingEdit").val(),
            completororder: $("#completororderEdit").val(),
            money: $("#moneyEdit").val(),
            num: $("#numEdit").val(),
            highestgrade: $("#highestgradeEdit").val(),
            cooperation: $("#cooperationEdit").val(),
            expertise: $("#expertiseEdit").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>




<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="id" hidden value="${dept.deptId}">
<input id="pId" hidden value="${dept.parentDeptId}">
<input id="pDeptType" hidden  value="${pDeptType}">
<div class="col-md-12">
    <div class="block block-drop-shadow">
        <div class="header">
            <span style="font-size: 14px">${dept.deptName}</span>
        </div>
        <div class="content controls" style="height: 80%">
            <div class="form-row">
                <div class="col-md-3 tar">
                    组织机构名称
                </div>
                <div class="col-md-9">
                    <input id="deptName" type="text"
                           class="validate[required,maxSize[20]] form-control"
                           value="${dept.deptName}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    组织机构详情
                </div>
                <div class="col-md-9">
                    <input id="deptDescription" type="text"
                           class="validate[required,minSize[5],maxSize[10]] form-control"
                           value="${dept.deptDescription}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    组织机构类别
                </div>
                <div class="col-md-9">
                    <select id="deptType" class="js-example-basic-single"></select>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    组织机构排序
                </div>
                <div class="col-md-9">
                    <input id="deptOrder" type="number" value="${dept.deptOrder}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    是否是领导部门
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio"  ${dept.leaderFlag=="1"? 'checked':""}
                                   class="validate[required]"
                                   name="leaderFlag"
                                   value="1"/> 是
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" ${dept.leaderFlag=="0"? 'checked':""}
                                   class="validate[required]"
                                   name="leaderFlag"
                                   value="0"/> 否
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    是否是教学部
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio"  ${dept.teachingFlag=="1"? 'checked':""}
                                   class="validate[required]"
                                   name="teachingFlag"
                                   value="1"/> 是
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" ${dept.teachingFlag=="0"? 'checked':""}
                                   class="validate[required]"
                                   name="teachingFlag"
                                   value="0"/> 否
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    是否是启用
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" ${dept.validFlag=="1"? 'checked':""}
                                   class="validate[required]"
                                   name="validFlag"
                                   value="1"/> 是
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" ${dept.validFlag=="0"? 'checked':""}
                                   class="validate[required]"
                                   name="validFlag"
                                   value="0"/> 否
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div style="text-align: center">
                    <button class="btn btn-default btn-clean" onclick="saveDept()">保存</button>
                    <button class="btn btn-default btn-clean" onclick="deptObjhide()">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="deptTypeCache" hidden value="${dept.deptType}">
<script>
    $(document).ready(function () {
        var deptTypeCache = $("#deptTypeCache").val();
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TYJB", function (data) {
            addOption(data, 'deptType', deptTypeCache)
        });
    })

    $("#deptType").change(function(){
        if($("#deptType option:selected").val()!="" && parseInt($("#deptType option:selected").val()) < parseInt($("#pDeptType").val())  ){
            swal({
                title: "不能超过上级组织机构级别！",
                type: "info"
            });
            //alert("不能超过上级组织机构级别");
        }
    });

    function saveDept() {
        if ($("#deptName").val() == ""  || $("#deptName").val() == null) {
            swal({
                title: "请填写组织机构名称！",
                type: "info"
            });
            //alert("请填写组织机构名称");
            return;
        }
        if ($("#deptName").val().length>50) {
            swal({
                title: "组织机构名称过长！",
                type: "info"
            });
            //alert("组织机构名称过长");
            return;
        }
        if ($("#deptType option:selected").val() == ""  || $("#deptType option:selected").val() == null) {
            swal({
                title: "请填写组织机构类别！",
                type: "info"
            });
            //alert("请填写组织机构类别");
            return;
        }
        if ($("#deptDescription").val() == ""  || $("#deptDescription").val() == null) {
            swal({
                title: "请填写组织机构详情！",
                type: "info"
            });
            //alert("请填写组织机构详情");
            return;
        }
        if ($("#deptOrder").val() == ""  || $("#deptOrder").val() == null) {
            swal({
                title: "请填写组织机构排序！",
                type: "info"
            });
            //alert("请填写组织机构排序");
            return;
        }
        if($("#deptType option:selected").val()!="" && parseInt($("#deptType option:selected").val()) < parseInt($("#pDeptType").val())  ){
            swal({
                title: "不能超过上级组织机构级别！",
                type: "info"
            });
            //alert("不能超过上级组织机构级别");
            return;
        }
        $.post("<%=request.getContextPath()%>/checkDeptName",{
            deptId: $("#id").val(),
            deptName: $("#deptName").val(),
            parentDeptId: $("#pId").val()
        },function(msg) {
            if (msg.status == 1) {
                swal({
                    title: "同级部门中该名称已存在！",
                    type: "error"
                });
            } else {
                $.post("<%=request.getContextPath()%>/updateDept", {
                    deptId: $("#id").val(),
                    deptName: $("#deptName").val(),
                    parentDeptId: $("#pId").val(),
                    deptType: $("#deptType").val(),
                    deptDescription: $("#deptDescription").val(),
                    teachingFlag: $("input[name='teachingFlag']:checked").val(),
                    deptOrder: $("#deptOrder").val(),
                    validFlag: $("input[name='validFlag']:checked").val(),
                    leaderFlag: $("input[name='leaderFlag']:checked").val(),
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        //alert(msg.msg);
                        refreDeptTree();
                    }
                })
            }
        })
    }
</script>
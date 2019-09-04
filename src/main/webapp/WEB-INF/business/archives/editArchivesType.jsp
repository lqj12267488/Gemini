<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="id" hidden value="${archivesType.typeId}">
<input id="pId" hidden value="${archivesType.parentTypeId}">
<div class="col-md-12">
    <div class="block block-drop-shadow">
        <div class="header">
            <span style="font-size: 14px">${name}</span>
        </div>
        <div class="content controls" style="height: 80%">
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    类别名称
                </div>
                <div class="col-md-9">
                    <input id="deptName" type="text"
                           class="validate[required,maxSize[20]] form-control"
                           value="${archivesType.typeName}"/>
                </div>
            </div>
            <div class="form-row" id="tnumid" style="display: none;">
                <div class="col-md-3 tar">
                    类别编号
                </div>
                <div class="col-md-9">
                    <input id="tNum" type="text"
                           class="validate[required,maxSize[8]] form-control"
                           value="${archivesType.newTypeId}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>
                    排序
                </div>
                <div class="col-md-9">
                    <input id="deptOrder" type="number" value="${archivesType.deptOrder}"/>
                </div>
            </div>
            <div class="form-row" id="apt" style="display: none;">
                <div class="col-md-3 tar">
                    是否公共类
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" class="validate[required]" name="publicType"
                            ${archivesType.publicType=="1"? 'checked':""} value="1"/> 是
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" class="validate[required]" name="publicType"
                            ${archivesType.publicType=="0"? 'checked':""} value="0"/> 否
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
<input id="pname" hidden value="${name}">
<script>
    var newtnum;
    $(document).ready(function () {
        if($("#id").val().length=='6'){
            document.getElementById("apt").style.display = "";
            document.getElementById("tnumid").style.display = "";
        }
    })
    function saveDept() {
        var reg = /^[0-9]+.?[0-9]*$/;
        var publicType = $("input[name='publicType']:checked").val();
        if ($("#deptName").val() == ""  || $("#deptName").val() == null) {
            swal({
                title: "请填写名称！",
                type: "info"
            });
            return;
        }
        if ($("#deptName").val().length>50) {
            swal({
                title: "名称过长！",
                type: "info"
            });
            return;
        }
        if($("#id").val().length=='6') {
            newtnum='${id}'.substring(0,3)+$("#tNum").val();
            if ($("#tNum").val() == "" || $("#tNum").val() == null) {
                swal({
                    title: "请填写类别编号！",
                    type: "info"
                });
                return;
            }
            if(!reg.test($("#tNum").val())){
                swal({
                    title: "类别编号请填写数字！",
                    type: "info"
                });
                return;
            }
            if ($("#tNum").val().length!=3) {
                swal({
                    title: "类别编号必须是3位数！",
                    type: "info"
                });
                return;
            }
            if (publicType == "" || publicType == null) {
                swal({
                    title: "请选择是否公共类！",
                    type: "info"
                });
                return;
            }
        }else {
            publicType="";
            newtnum='${id}';
        }
        $.post("<%=request.getContextPath()%>/archivesType/checkName", {
            typeId: '${id}',
            typeName: $("#deptName").val(),
            parentTypeId: $("#pId").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: "名称重复，请重新填写！", type: "error"});
            }
            else {
                if($("#id").val().length==6) {
                    $.post("<%=request.getContextPath()%>/archivesType/checkId", {
                        newTypeId: $("#tNum").val(),
                        typeId:$("#id").val(),
                        parentTypeId: $("#pId").val(),
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: "编号重复，请重新填写！", type: "error"});
                        }else {
                            $.post("<%=request.getContextPath()%>/archivesType/updateArchivesType", {
                                newTypeId: newtnum,
                                typeId:$("#id").val(),
                                typeName: $("#deptName").val(),
                                parentTypeId: $("#pId").val(),
                                publicType: publicType,
                                deptOrder:$("#deptOrder").val()
                            }, function (msg) {
                                if (msg.status == 1) {
                                    swal({title: msg.msg, type: "success"});
                                    var treeObj = $.fn.zTree.getZTreeObj("deptTree");
                                    refrearchivesTree();
                                }
                            })
                        }
                    })
                }else {
                    $.post("<%=request.getContextPath()%>/archivesType/updateArchivesType", {
                        newTypeId: $("#id").val(),
                        typeId: $("#id").val(),
                        typeName: $("#deptName").val(),
                        parentTypeId: $("#pId").val(),
                        publicType: publicType,
                        deptOrder:$("#deptOrder").val()
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            refrearchivesTree();
                        }
                    })
                }
            }
        })
    }
</script>
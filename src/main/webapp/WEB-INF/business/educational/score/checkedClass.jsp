<%--
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2018/3/15
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">选择班级</span>
        </div>
        <div class="modal-body clearfix">

            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>班级
                    </div>
                    <div class="col-md-9">
                        <select id="checked_classId" class="form-control">
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="exportScore1()">导出</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>



    $(function(){
        $.get("<%=request.getContextPath()%>/scoreMakeup/getQueryList?scoreExamId=${scoreExamId}", function (data) {
            if(data != null){
                addOption(data["classSelect"], 'checked_classId');
            }
        });
    });

    function exportScore1() {

        var classId = $("#checked_classId").val();

        if(classId != null && classId != ""){

            window.location.href = "<%=request.getContextPath()%>/score/export?scoreExamId=${scoreExamId}&examTypes=${examTypes}&scoreType=${scoreType}&classId="+classId;

        } else {

            swal({
                title: "请选择要导出的班级",
                type: "info"
            });
            return;
        }
    }
</script>



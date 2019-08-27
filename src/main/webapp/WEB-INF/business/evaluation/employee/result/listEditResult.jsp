<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div  id="layout" class="loading" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center">
            <br/><br/><br/>
            <img src="<%=request.getContextPath()%>/libs/img/app/loading.gif" style="width:100px;height: 100px;text-align: center"/>
            <br/><br/><br/>
            <h3  style="size: 20px;color: #bb1111;"><B>正在提交，请稍后……</B></h3>
        </div>
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">评教任务：${taskName} &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;被评教人： ${empName} </h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <c:forEach items="${iList}" var="iListFri"><!-- 循环第一层-->
                <c:choose>
                    <c:when test="${iListFri.leafFlag == 0 }">
                        <div class="form-row">
                            <div class="col-md-12" style="background:#048ADB"><%--style="background: #2FC27B"--%>
                                <b>${iListFri.indexName}</b>
                            </div>
                        </div>
                        <c:forEach items="${iListFri.indexList}" var="indexListSe">
                            <c:choose>
                                <c:when test="${indexListSe.leafFlag == 0 }">
                                    <div class="form-row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-11"style="background:#13A4FB" ><%--style="background: #7968EC"--%>
                                            ${indexListSe.indexName}
                                        </div>
                                    </div>
                                    <c:forEach items="${indexListSe.indexList}" var="indexListTre">
                                       <%-- <h5><a>${indexListTre.score}</a><a>${indexListTre.indexName}</a></h5>--%>
                                        <div class="form-row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-10" style="background:#69C5FC"><%--style="background:#DCA0DC"--%>
                                                ${indexListTre.indexName}(满分${indexListTre.score})
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-4 tar">
                                                评分:
                                            </div>
                                            <div class="col-md-8">
                                                <input type="hidden" name="indexName" value="${indexListTre.indexName}"/>
                                                <input type="hidden" name="macScore" value="${indexListTre.score}"/>
                                                <input type="hidden" name="indexId" value="${indexListTre.indexId}"/>
                                                <input type="text" name="score" width="100%" placeholder="请输入分数"/>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-4 tar">
                                                评语:
                                            </div>
                                            <div class="col-md-8">
                                                <input type="text" name="remark" width="100%"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${indexListSe.leafFlag == 1 }">
                                    <%--<h3><a>${indexListSe.score}</a>
                                        <a>${indexListSe.indexName}</a></h3>--%>
                                    <div class="form-row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-11" style="background: #13A4FB"><%--style="background: #7968EC"--%>
                                            ${indexListSe.indexName}(满分${indexListSe.score})
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-4 tar">
                                            评分:
                                        </div>
                                        <div class="col-md-8">
                                            <input type="hidden" name="indexName" value="${indexListSe.indexName}"/>
                                            <input type="hidden" name="macScore" value="${indexListSe.score}"/>
                                            <input type="hidden" name="indexId" value="${indexListSe.indexId}"/>
                                            <input type="text" name="score" width="100%" placeholder="请输入分数" />
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-4 tar">
                                            评语:
                                        </div>
                                        <div class="col-md-8">
                                            <input type="text" name="remark" width="100%"/>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:when test="${iListFri.leafFlag == 1 }">
                    <div class="form-row">
                        <div class="col-md-12" style="background: #048ADB"><%--style="background: #2FC27B"--%>
                            ${iListFri.indexName}(满分${iListFri.score})
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">
                            评分:
                        </div>
                        <div class="col-md-8">
                            <input type="hidden" name="indexName" value="${iListFri.indexName}"/>
                            <input type="hidden" name="macScore" value="${iListFri.score}"/>
                            <input type="hidden" name="indexId" value="${iListFri.indexId}"/>
                            <input type="text" name="score" width="100%" placeholder="请输入分数"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4 tar">
                            评语:
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="remark" width="100%"/>
                        </div>
                    </div>
                    </c:when>
                </c:choose>
                </c:forEach><!--end 循环第一层-->
                <div class="form-row tar">
                    <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">提交</button>
                    <button type="button" id="closeBtn" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="taskId" value="${taskId}" hidden>
<input id="empPersonId" value="${empPersonId}" hidden>
<input id="empDeptId" value="${empDeptId}" hidden>
<input id="empName" value="${empName}" hidden>
<script>

    function save() {
        var scoreVale=new Array();
        var indexIdVale=new Array();
        var remarkVale=new Array();
        var macScoreVale=new Array();
        var indexNameVale=new Array();

        var Scorecheck = false;
        var al="";var bl="";
        $("[name=indexId]").each(function () {
            indexIdVale.push(this.value);
        });
        $("[name=score]").each(function () {
            if(null ==this.value ||this.value ==""){
                al="请填写评分，评分不能为空！"
                return;
            }
            scoreVale.push(this.value);
        });
        $("[name=remark]").each(function () {
/*
            if(null == this.value || this.value ==""){
                bl ="请填写评语，评语不能为空！" ;
                return;
            }
*/
            remarkVale.push(this.value);
        });
        $("[name=macScore]").each(function () {
            macScoreVale.push(this.value);
        });
        $("[name=indexName]").each(function () {
            indexNameVale.push(this.value);
        });
        if(!(al)==""){
            swal({
                title: ""+al+"",
                type: "info"
            });
            return;
        }
        for(var i= 0;i<scoreVale.length;i++){
            if(isNaN(scoreVale[i])){
                swal({
                    title: ""+indexNameVale[i]+"的分数填写异常，分数应为数字",
                    type: "info"
                });
                return;
            }
            if(parseInt(scoreVale[i])>parseInt(macScoreVale[i]) ){
                swal({
                    title: ""+indexNameVale[i]+"的评分已超过最大值",
                    type: "info"
                });
                return;
            }
            if(parseInt(scoreVale[i]) < parseInt(macScoreVale[i]) ){
                Scorecheck = true;
            }
            if(parseInt(scoreVale[i])< 0 ){
                swal({
                    title: "评分不能为负数！",
                    type: "info"
                });
                return;
            }
        }
        if( ! Scorecheck ){
            swal({
                title: "不可以将所有评分项均设置为满分，请进行调整！",
                type: "info"
            });
            return;
        }
        var returnValue ="";
        for(var i=0;i<scoreVale.length;i++){
            if(returnValue==""){
                returnValue = indexIdVale[i]+"##"+scoreVale[i]+"##"+remarkVale[i];
            }else{
                returnValue = returnValue+"@@@@"+indexIdVale[i]+"##"+scoreVale[i]+"##"+remarkVale[i];
            }
        }

        insertResult(returnValue);
        scoreVale=new Array();
        indexIdVale=new Array();
        remarkVale=new Array();
        macScoreVale=new Array();
        indexNameVale=new Array();
        $('.modal-dialog').css('opacity','');
        $("#layout").css('display','block');
    }

    function insertResult(returnValue){
        $('.loading').css('background-color','rgba(174, 173, 173, 0.4)');
        $("#layout").css('display','block');
        $('#saveBtn').attr('disabled',"disabled");
        $('#closeBtn').attr('disabled',"disabled");
        $("[name=score]").attr("disabled","disabled");
        $("[name=remark]").attr("disabled","disabled");

        $.post("<%=request.getContextPath()%>/evaluation/result/insertResult",
            {
                taskId:$("#taskId").val(),
                empPersonId:$("#empPersonId").val(),
                empDeptId:$("#empDeptId").val(),
                empName:$("#empName").val(),
                returnValue:returnValue,
            },
            function (msg) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal("hide");
                empEvalTable.ajax.reload();
            })
    }

</script>
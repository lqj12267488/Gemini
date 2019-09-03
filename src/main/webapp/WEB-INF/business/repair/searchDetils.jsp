<%--报修类型管理新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/5/26
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header" style="height: 50px">
            <span style="font-size: 14px">${head}</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <button type="button" class="btn btn-default btn-clean" onclick="printDate()">打印
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">返回
            </button>
            <input id="rID" hidden value="${repair.repairID}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修人
                    </div>
                    <div class="col-md-9">
                        <input id="creatorSel" class="js-example-basic-single" value="${repair.creator}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修时间
                    </div>
                    <div class="col-md-9">
                        <input id="Submit_Time" class="js-example-basic-single" value="${repair.submitTime}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        报修物品名称
                    </div>
                    <div class="col-md-9">
                        <input id="itemNameSel" class="js-example-basic-single" value="${repair.itemNameShow}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        维修地址
                    </div>
                    <div class="col-md-9">
                        <input id="Repair_Address" class="js-example-basic-single" value="${repair.repairAddress}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        故障描述
                    </div>
                    <div class="col-md-9">
                        <input id="faultDescriptionSel" class="js-example-basic-single" value="${repair.faultDescription}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        联系人电话
                    </div>
                    <div class="col-md-9">
                        <input id="contactNumberSel" class="js-example-basic-single" value="${repair.contactNumber}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        派单人
                    </div>
                    <div class="col-md-9">
                        <input id="sysNameSel" class="js-example-basic-single" value="${repair.sysName}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        派单时间
                    </div>
                    <div class="col-md-9">
                        <input id="assignTimeSel" class="js-example-basic-single" value="${repair.assignTime}" readonly></input>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        维修人
                    </div>
                    <div class="col-md-9">
                        <input id="personIdSel" class="js-example-basic-single" value="${repair.personIdShow}" readonly></input>
                    </div>
                </div>



            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" >关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "dic_code",
                text: "dic_name",
                tableName: "T_SYS_USERDIC",
                where: " WHERE 1 = 1 and dic_type='BXLXGL' and VALID_FLAG=1",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "repairType", '${repair.repairType}');
            });
    })

    function printDate() {
        var repairID = $("#rID").val();
        var iframe=document.getElementById("print-iframe");
        if(!iframe){
            //var el = document.getElementById("printcontent");

            iframe = document.createElement('IFRAME');
            var doc = null;
            iframe.setAttribute("id", "print-iframe");
            iframe.setAttribute('style', 'position:absolute;width:0px;height:0px;left:-500px;top:-500px;');
            document.body.appendChild(iframe);
        }
        var print = "<%=request.getContextPath()%>/repair/printDistribution?repairID="+repairID;
        $.get(print, function (html) {
            console.log(html);
            doc = iframe.contentWindow.document;
            //这里可以自定义样式
            //doc.write("<LINK rel="stylesheet" type="text/css" href="css/print.css">");
            doc.write('<div>' + html + '</div>');
            doc.close();
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
        })
    }



</script>



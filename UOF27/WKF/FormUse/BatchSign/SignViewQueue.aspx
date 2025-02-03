<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="SignViewQueue.aspx.cs" Inherits="Ede.Uof.Web.WKF.FormUse.BatchSign.SignViewQueue" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        Sys.Application.add_load(function () {
            formFilter();
        })

        function AllCheck(e) {
            var checkId = $(e).prop("id");
            var controls = $("input:checkbox");

            for (var i = 0; i < controls.length; i++) {

                var objEle = $(controls[i]);
                if (objEle.prop("id").split("_")[0] + '_' + objEle.prop("id").split("_")[1] + '_' + objEle.prop("id").split("_")[2] == checkId && objEle.prop("id") != checkId) {
                    if (!objEle.prop("disabled")) {
                        objEle.prop("checked", $(e).prop("checked"));

                    }
                }

            }
        }

        function CustSign(labelId, sender) {
            var signWindowWidth = <%=signWindowWidth%>;
            var signWindowHeight = <%=signWindowHeight%>;
            var taskId = labelId.split("_")[1];
            var siteId = labelId.split("_")[2];
            var nodeSeq = labelId.split("_")[3];
            var agent = labelId.split("_")[4];
            this.enabled = false;
            $uof.dialog.open2("~/WKF/FormUse/FreeTask/SignNodeForm.aspx", sender, '',<%=signWindowWidth%>,<%=signWindowHeight%>, function () { return true; }, { 'TASK_ID': taskId, 'SITE_ID': siteId, 'NODE_SEQ': nodeSeq, 'isBatchSign': 'true', 'AGENT': agent });
            //return false;
        }

        function SetDropDownListStatus(status) {
            var ddlformList = $("#<%=radToolbar1.Items.FindItemByValue("radBtnItems").FindControl("ddlFormList").ClientID%>");
            if (ddlformList != null) {
                ddlformList.prop("disabled", status);
            }
        }

        function NoCheckRefresh() {
            var allChecks = $("input:checkbox");
            alert("<%=lbl_NoChoiseForm.Text%>");
            for (var i = 0; i < allChecks.length; i++) {
                allChecks.prop("disabled", false);
            }
        }

        //ddlFormList OnChange
        function changeFormCategory(sender, args) {
            var ddlSelected = args.get_item();
            var hfFormId = $('#<%=hfFormId.ClientID%>');
            hfFormId.val(ddlSelected.get_value());
            formFilter();

        }

        ///JQuery控制表單顯示與否
        function formFilter() {
            var hfFormId = $('#<%=hfFormId.ClientID%>');
            if ($uof.tool.htmlDecode(hfFormId.val()) == "all")
                $(".NormalPopTable").show();
            else {
                $(".NormalPopTable").hide();
                $("table[formId='" + hfFormId.val() + "']").show();
            }
        }


        function OpenSignComment(e) {
            $uof.dialog.open2('~/WKF/FormUse/BatchSign/SignComment.aspx', '', '', 1000, 600, function () { return false; }, { 'TASK_ID': e });
            return false;
        }

        function ShowRefreshLabel(){
            var radTBMemo = $("#<%=radToolbar1.Items.FindItemByValue("radTBMemo").FindControl("lblTBMemo").ClientID%>");
            radTBMemo.show();
            setTimeout(function () {
                alert('<%=lbl_ProccessEndMsg.Text%>');

            }, 1000);
        }

        function SignForm(processingText, userId, userIp) {
            var taskIdInfo = new Array();
            SetDropDownListStatus(true);
            m_count = 0;
            var controls = $("input:checkbox");

            for (var i = 0; i < controls.length; i++) {
                var objEle = $(controls[i]);

                objEle.prop("disabled", true);

                if (objEle.prop("checked")) {
                    if (objEle.prop("name").indexOf("_") > 0) {
                        var controlName = objEle.prop("name");

                        controlName = controlName.replace("ctl00$ContentPlaceHolder1$", "ctl00_ContentPlaceHolder1_labels");
                        var jSelector = "#" + controlName;
                        $(jSelector).html("<br><img src='../../../Common/Images/loading.gif' border='0' id='Imgs'>" + processingText + "...");
                        taskIdInfo[m_count] = controlName;
                        m_count++;
                    }
                }

            }

            if (m_count == 0) {
                NoCheckRefresh();
                return;
            }

            //批次簽核開始後按鈕就消失
            $("#ctl00_PanelButton1").hide();

            $uof.pageMethod.async("BatchSignQueue", [JSON.stringify(taskIdInfo)], callSet);
            ShowRefreshLabel();

            return false;
        }

        function callSet(s) {
            var controls = $("input:checkbox");
            for (var i = 0; i < controls.length; i++) {
                var objEle = $(controls[i]);
                if (objEle.prop("checked")) {
                    if (objEle.prop("name").indexOf("_") > 0) {
                        var controlName = objEle.prop("name");

                        controlName = controlName.replace("ctl00$ContentPlaceHolder1$", "ctl00_ContentPlaceHolder1_labels");
                        var jSelector = "#" + controlName;
                        $(jSelector).html("<%=lblSentQueue.Text%>");
                     }
                 }
             }
         }
    </script>

    <div id="layer0" style="width: 100%; height: 5%; border: 0px;">
        <telerik:RadToolBar ID="radToolbar1" runat="server" Width="100%" OnButtonClick="radToolbar1_ButtonClick">
            <Items>
                <telerik:RadToolBarButton runat="server" Value="radBtnItems">
                    <ItemTemplate>
                        <table border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblFormList" runat="server" Text="過濾表單：" meta:resourcekey="lblFormListResource1"></asp:Label></td>
                                <td>
                                    <telerik:RadDropDownList ID="ddlFormList" runat="server" OnClientItemSelected="changeFormCategory"></telerik:RadDropDownList>
                                    &nbsp;&nbsp;&nbsp;
                    <img src='<%=themePath %>/Images/Icon_m10211.gif' border='0' title='<%=Label2.Text%>'>&nbsp;:&nbsp;<%=Label2.Text%></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadToolBarButton>
                <telerik:RadToolBarButton IsSeparator="true" runat="server"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton runat="server" Value="refresh" Text="重新整理" ImageUrl="~/common/images/icon/icon_m38.png" meta:resourcekey="lbl_RefreshResource1"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton IsSeparator="true" runat="server"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton runat="server" Value="radTBMemo">
                    <ItemTemplate>
                        <asp:Label ID="lblTBMemo" style="display:none" runat="server" Text="請重新整理以取得最新狀態。" ForeColor="Blue" meta:resourcekey="lblTBMemoResource1"></asp:Label>
                    </ItemTemplate>
                </telerik:RadToolBarButton>
            </Items>
        </telerik:RadToolBar>
    </div>
    <div id="Layer1" style="width: 100%; height: 94%; overflow: auto; visibility: visible; border: 0px">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>

                <asp:Table ID="TB_SIGN" runat="server" meta:resourcekey="TB_SIGNResource1"></asp:Table>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--<asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="SignCheck" Display="Dynamic" meta:resourcekey="CustomValidator1Resource1"></asp:CustomValidator>--%>
    <asp:Label ID="lbl_Running" Text="簽核中...." Visible="False" runat="server" meta:resourcekey="lbl_RunningResource1"></asp:Label>
    <asp:Label ID="lbl_Finish" Text="完成－" Visible="False" runat="server" meta:resourcekey="lbl_FinishResource1"></asp:Label>
    <asp:Label ID="lbl_Fail" Text="失敗－" Visible="False" runat="server" meta:resourcekey="lbl_FailResource1"></asp:Label>
    <asp:Label ID="lbl_FormLocked" Text="表單由他人處理中" Visible="False" runat="server" meta:resourcekey="lbl_FormLockedResource1"></asp:Label>
    <asp:Label ID="lbl_FreeFlow" Text="自由流程" Visible="False" runat="server" meta:resourcekey="lbl_FreeFlowResource1"></asp:Label>
    <asp:Label ID="lbl_NotCurrentSite" Text="此站點非可處理站點" Visible="False" runat="server" meta:resourcekey="lbl_NotCurrentSiteResource1"></asp:Label>
    <asp:Label ID="lbl_FlowException" Text="讀取組織流程有出現錯誤" Visible="False" runat="server" meta:resourcekey="lbl_FlowExceptionResource1"></asp:Label>
    <asp:Label ID="lbl_CustSite" Text="自訂站點" Visible="False" runat="server" meta:resourcekey="lbl_CustSiteResource1"></asp:Label>
    <asp:Label ID="lbl_GroupSite" Text="自選站點" Visible="False" runat="server" meta:resourcekey="lbl_GroupSiteResource1"></asp:Label>
    <asp:Label ID="lbl_FreeSite" Text="自由流程站點" Visible="False" runat="server" meta:resourcekey="lbl_FreeSiteResource1"></asp:Label>
    <asp:Label ID="lbl_NoCondition" Text="條件不符" Visible="False" runat="server" meta:resourcekey="lbl_NoConditionResource1"></asp:Label>
    <asp:Label ID="lbl_NoSinger" Text="找不到簽核者" Visible="False" runat="server" meta:resourcekey="lbl_NoSingerResource1"></asp:Label>
    <asp:Label ID="lbl_NoChoiseForm" Text="請選擇表單" Visible="False" runat="server" meta:resourcekey="lbl_NoChoiseFormResource1"></asp:Label>
    <asp:Label ID="lbl_NoFormSign" Text="沒有可簽核表單" Visible="False" runat="server" meta:resourcekey="lbl_NoFormSignResource1"></asp:Label>
    <asp:Label ID="lbl_GeneralMsg" Text="一般站點不允許多人簽核" Visible="False" runat="server" meta:resourcekey="lbl_GeneralMsgResource1"></asp:Label>
    <asp:Label ID="lbl_EndForm" Text="表單已結案" Visible="False" runat="server" meta:resourcekey="lbl_EndFormResource1"></asp:Label>
    <asp:Label ID="lbl_NextSinger" Text="表單送往下一站" Visible="False" runat="server" meta:resourcekey="lbl_NextSingerResource1"></asp:Label>
    <asp:Label ID="lbl_NonResult" Text="簽核結果未達成共識" Visible="False" runat="server" meta:resourcekey="lbl_NonResultResource1"></asp:Label>
    <asp:Label ID="lbl_CustSign" Text="單筆簽核" Visible="False" runat="server" meta:resourcekey="lbl_CustSignResource1"></asp:Label>
    <asp:Label ID="lbl_Accept" Text="同意" Visible="False" runat="server" meta:resourcekey="lbl_AcceptResource1"></asp:Label>
    <asp:Label ID="lbl_Refresh" Text="重新整理" Visible="False" runat="server" meta:resourcekey="lbl_RefreshResource1"></asp:Label>
    <asp:Label ID="lbl_FormName" Text="表單名稱 － " Visible="False" runat="server" meta:resourcekey="lbl_FormNameResource1"></asp:Label>
    <asp:Label ID="lbl_FormTitle" Text="標題" Visible="False" runat="server" meta:resourcekey="lbl_FormTitleResource1"></asp:Label>
    <asp:Label ID="lbl_FormAccplication" Text="申請者" Visible="False" runat="server" meta:resourcekey="lbl_FormAccplicationResource1"></asp:Label>
    <asp:Label ID="lbl_SignStatus" Text="簽核狀態" Visible="False" runat="server" meta:resourcekey="lbl_SignStatusResource1"></asp:Label>
    <asp:Label ID="lbl_ProccessEndMsg" Text="表單已送至背景簽核，您可直接關閉視窗；\r也可以點按上方『重新整理』按鈕繼續操作。" Visible="False" runat="server" meta:resourcekey="lbl_ProccessEndMsgResource1"></asp:Label>
    <asp:Label ID="lbl_allForm" Text="全部" Visible="False" runat="server" meta:resourcekey="lbl_allFormResource1"></asp:Label>
    <asp:Label ID="lbl_RowClickMsg" Text="點選空白處可顯示簽核歷程" Visible="False" runat="server" meta:resourcekey="lbl_RowClickMsgResource1"></asp:Label>
    <asp:Label ID="lbl_SignerIsSuspendedorNonActive" runat="server" Text="下一站簽核者被停用" Visible="false" meta:resourcekey="lbl_SignerIsSuspendedorNonActiveResource1"></asp:Label>
    <asp:Label ID="Label1" Text="待簽表單" Visible="False" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
    <asp:Label ID="Label2" Text="代理簽核表單" Visible="False" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
    <asp:Label ID="lblBackgroundProcessing" Text="此表單已在背景簽核中" Visible="False" runat="server" meta:resourcekey="lblBackgroundProcessingResource1"></asp:Label>
    <asp:Label ID="lblSignalRError" Text="系統忙碌中，請稍後重試。" Visible="false" runat="server" meta:resourcekey="lblSignalRErrorResource1"></asp:Label>
    <asp:Label ID="lblSentQueue" Text="已送至背景簽核" Visible="false" runat="server" meta:resourcekey="lblSentQueueResource1"></asp:Label>
    <asp:HiddenField ID="hfFormId" runat="server" Value="all" />
    <asp:HiddenField ID="hiddenKey" runat="server" />
    <asp:HiddenField ID="HiddenUserId" runat="server" />
</asp:Content>
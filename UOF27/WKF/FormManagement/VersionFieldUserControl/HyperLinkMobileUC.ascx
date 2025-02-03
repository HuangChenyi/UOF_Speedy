<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HyperLinkUC.ascx.cs" Inherits="WKF_FormManagement_VersionFieldUserControl_HyperLinkUC" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<style>
    .mobileStyle {
        background-image: none !important;
        background-color: #2185D0 !important;
        color: #fff !important;
        padding: 0.2em 0.3em 0.4em 0.3em !important;
        border-radius: .28571429rem;
        vertical-align: baseline;
        box-shadow: none;
    }
</style>
<script>
    Sys.Application.add_load(
        function(){
            HideLink_<%=this.VersionField.FieldID%>();
        }
    );

    function HideLink_<%=this.VersionField.FieldID%>() {
        if ($uof.tool.browser.mobile_safari || $("#<%=hfIsDmsForm.ClientID%>").val() == "true") {
            $("#<%=lbtnHyperLink.ClientID%>").show();
            $("#<%=HyperLink1.ClientID%>").hide();
            $("#<%=lbtnHyperLink.ClientID%>").text($("#<%=HyperLink1.ClientID%>").text());
            $("#<%=lbtnHyperLink.ClientID%>").attr("href", "#");
            $("#<%=lbtnHyperLink.ClientID%>").attr("target", "_blank");

            // android的文件連結需抑制行為
            if (!$uof.tool.browser.mobile_safari && $("#<%=hfIsDmsForm.ClientID%>").val() == "true") {
                $("#<%=lbtnHyperLink.ClientID%>").click(function()
                {
                    //終止預設行為
                    event.preventDefault();
                });
            }
        }
        else{
            $("#<%=lbtnHyperLink.ClientID%>").hide();
            $("#<%=HyperLink1.ClientID%>").show();
        }
        if ($("#<%=hfIsDmsLink.ClientID%>").val() == "true") {
            $("#<%=lblHyperLink.ClientID%>").attr("style","pointer-events: none; color:gray");
        }

    }

    function HyperLinkClick_<%=this.VersionField.FieldID%>() {
        CheckUrlIsDMSPathOrOMSPath_<%=this.VersionField.FieldID%>();
  
        var ajaxManager;
        if (ajaxManager == null)
            ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");

        ajaxManager.ajaxRequest(JSON.stringify({ "Key": "SaveForm", "Value": "" }));

        setInterval(function () {
            window.location.href = '#InAppBrowserIOSRedirect:' + $("#<%=HyperLink1.ClientID%>").attr("href");
        }, 200);

        return false;
    }

    function HyperLink1Click_<%=this.VersionField.FieldID%>() {
        CheckUrlIsDMSPathOrOMSPath_<%=this.VersionField.FieldID%>();
    }

    function CheckUrlIsDMSPathOrOMSPath_<%=this.VersionField.FieldID%>(){
        
        var hyperLink = $("#<%=HyperLink1.ClientID%>");

        debugger;
        //此處的用意是為了讓APP簽表單點選文件、影音連結的時候，不要將該連結轉為APP格式，特別加一個參數InAppBrowser好讓MapPath.cs判斷
        let url = hyperLink.attr('href');
        let decodeUrl = decodeURI(url);
        let isMatch = false;
        let isMatch2 = false;
        let isMatch3 = 0;
        const sPattern = /\/DMS@(\w{12})\.aspx$/;
        const sPattern2 = /\/DMS※(\w{12})\.aspx$/;
        const re = new RegExp(sPattern);
        const re2 = new RegExp(sPattern2);
        isMatch = re.test(decodeUrl);
        isMatch2 = re2.test(decodeUrl);
        isMatch3 = url.indexOf("OnlineLookShow.aspx");
        
        if (isMatch || isMatch2 || isMatch3 > 0) {
        
            if (url.indexOf('InAppBrowser') > 0)
                return;
        
            if (url.indexOf('DMS') > 0) 
                hyperLink.attr('href', url +'?InAppBrowser=1');

            else if (url.indexOf('OnlineLookShow.aspx') > 0)
                hyperLink.attr('href', url +'&InAppBrowser=1');
        }
    }

    function GetCurrentUrl() {
        return "<%=currentUrl%>";
    }
</script>
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest" ></telerik:RadAjaxManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">

    <ContentTemplate>

        <table border="0" cellpadding="0" cellspacing="0" style="width: 97%">
            <tr>
                <td>
                    <asp:LinkButton ID="lnk_Edit" runat="server" OnClick="lnk_Edit_Click" Visible="False" CausesValidation="False" meta:resourcekey="lnk_EditResource1">[修改]</asp:LinkButton>
                    <asp:LinkButton ID="lnk_Cannel" runat="server" OnClick="lnk_Cannel_Click" Visible="False" CausesValidation="False" meta:resourcekey="lnk_CannelResource1">[取消]</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td id="tdInvisible" runat="server">
                    <asp:Label ID="lblInvisible" runat="server" Text="******"></asp:Label>
                </td>
                <td id="tdEdit" runat="server" nowrap>
                    <telerik:RadButton ID="WebImageButton1" runat="server" AutoPostBack="true" 
                        CausesValidation="False" OnClick="WebImageButton1_Click1" Text="設定超連結"
                        meta:resourcekey="WebImageButton1Resource1" Visible="False" EnableTheming="true">
                    </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="divVisible" runat="server">
                        <asp:LinkButton ID="lbtnHyperLink" runat="server" ForeColor="Blue"  style="-webkit-text-size-adjust: 100%"></asp:LinkButton>
                        <asp:HyperLink ID="HyperLink1" runat="server" meta:resourcekey="HyperLink1Resource1" ForeColor="Blue"></asp:HyperLink>
                        <asp:LinkButton ID="lblHyperLink" runat="server" ForeColor="Blue" meta:resourcekey="lblHyperLinkResource1"></asp:LinkButton>
                        <asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
                        <asp:HyperLink id="hyperlinkFocus1" NavigateUrl="#" runat="server"/>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="不允許空白" ForeColor="Red" EnableTheming="true"
                            meta:resourcekey="CustomValidator1Resource1" Visible="false" Display="Dynamic">
                        </asp:CustomValidator>
                    </div>
                    <asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
                    <asp:Label ID="lblFiller" CssClass="FillerVisible" runat="server" meta:resourcekey="lblFillerResource1"></asp:Label>
                    <asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
                    <asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
                    <asp:Label ID="lblMsgEditor" runat="server" Text="修改者" Visible="False" meta:resourcekey="lblMsgEditorResource1"></asp:Label>
                    <asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>
                    <asp:HiddenField ID="hiddenDefaultValue" runat="server" />
                    <asp:HiddenField ID="hfIsDmsForm" runat="server" />
                    <asp:HiddenField ID="hfIsDmsLink" runat="server" />
                </td>
            </tr>
        </table>
            </ContentTemplate>
</asp:UpdatePanel>

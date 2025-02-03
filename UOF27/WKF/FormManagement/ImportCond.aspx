<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="ImportCond.aspx.cs" Inherits="Ede.Uof.Web.WKF.FormManagement.ImportCond" culture="auto" uiculture="auto" meta:resourcekey="PageResource1" %>
<%@ Register Src="~/Common/FileCenter/V3/UC_FileCenter.ascx" TagPrefix="uc2" TagName="UC_FileCenter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table class="PopTable" cellspacing="1">
        <tr>
            <td style="white-space: nowrap;">
                <asp:Label ID="Label1" runat="server" Text="選擇匯入檔案" meta:resourcekey="Label1Resource1"></asp:Label>
            </td>
            <td>                
                <uc2:UC_FileCenter runat="server" id="UC_FileCenter" AllowedMultipleFileSelection="false" AllowedFileType="Excel"  ModuleName="WKF" ProxyEnabled="false" />                
                <asp:Label ID="Label2" runat="server" Text="匯入的檔案請從匯出取得" ForeColor="Blue" meta:resourcekey="Label2Resource1"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Label id="lblMsgImportError" runat="server" Visible="False" ForeColor="Red" Text ="匯入失敗" meta:resourcekey="lblMsgImportErrorResource1"></asp:Label>
    <asp:TextBox ID="txtMsg" runat="server" ReadOnly="True" Rows="15" TextMode="MultiLine" Visible="false" Width="100%"></asp:TextBox>
    <asp:Label ID="lblMsgDataError" runat="server" Text="匯入檔案格式錯誤，請使用匯出檔案進行匯入！" Visible="False" meta:resourcekey="lblMsgDataErrorResource1"></asp:Label>
    <asp:Label ID="lblFileNotParse" runat="server"  Text="匯入的檔案無法解析" Visible="False" meta:resourcekey="lblFileNotParseResource1" ></asp:Label>
    <asp:Label ID="lblSuccess" runat="server" Text="匯入成功,共匯入{0}筆資料" Visible="False" meta:resourcekey="lblSuccessResource1"></asp:Label>
    <asp:Label ID="lblFormateErrorMsg" runat="server" Text="匯入檔案格式錯誤，請重新上傳！" Visible="False" meta:resourcekey="lblFormateErrorMsgResource1"></asp:Label>    
    <asp:Label ID="lblMsg" runat="server" Text="請上傳檔案!" Visible="False" meta:resourcekey="lblMsgResource1"></asp:Label>
    <asp:Label ID="lblConditions" runat="server" Text="表單條件" Visible="False" meta:resourcekey="lblConditionsResource1"></asp:Label>
    <asp:Label ID="lblAbbreviation" runat="server" Text="簡稱" Visible="False" meta:resourcekey="lblAbbreviationResource1"></asp:Label>
</asp:Content>

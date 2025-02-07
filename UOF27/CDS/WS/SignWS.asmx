<%@ WebService Language="C#" Class="SignWS" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
    using System.Data;
    using Training.UCO;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
public class SignWS  : System.Web.Services.WebService {

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public string CheckedForm(string formInfo)
    {

        //<Form formVersionId="910a6cb8-c380-436c-aff3-4f7c520d0632">
        //  <FormFieldValue>
        //    <FieldItem fieldId="NO" fieldValue="" realValue="" enableSearch="True" />
        //    <FieldItem fieldId="A05" fieldValue="Mary(Mary)、HR(HR)" realValue="&lt;UserSet&gt;&lt;Element type='user'&gt; &lt;userId&gt;cd2f2e14-8a74-45a5-a667-4f91b21460bc&lt;/userId&gt;&lt;/Element&gt;&lt;Element type='user'&gt; &lt;userId&gt;335af80b-a806-436d-b5e5-b463ef3ef01f&lt;/userId&gt;&lt;/Element&gt;&lt;/UserSet&gt;&#xD;&#xA;" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
        //    <FieldItem fieldId="A01" fieldValue="33" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
        //    <FieldItem fieldId="A02" fieldValue="3" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
        //    <FieldItem fieldId="A03" fieldValue="3" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
        //    <FieldItem fieldId="A04" fieldValue="" realValue="" enableSearch="True" />
        //  </FormFieldValue>
        //</Form>
        formInfo = HttpUtility.UrlDecode(formInfo);

        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(formInfo);

        XmlDocument returnXmlDoc = new XmlDocument();
        XmlElement returnValueElement = returnXmlDoc.CreateElement("ReturnValue");
        XmlElement statusElement = returnXmlDoc.CreateElement("Status");
        XmlElement exceptionElement = returnXmlDoc.CreateElement("Exception");
        XmlElement messageElement = returnXmlDoc.CreateElement("Message");

        returnValueElement.AppendChild(statusElement);
        exceptionElement.AppendChild(messageElement);
        returnValueElement.AppendChild(exceptionElement);
        returnXmlDoc.AppendChild(returnValueElement);

        try
        {

                DemoUCO uco = new DemoUCO();
            string aFormNbr = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='NO']").Attributes["fieldValue"].Value;
                DataTable dt = uco.GetSignForm(aFormNbr);
            
            if (dt.Rows.Count>0)
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "還有其他會辦單尚完結案";
            }
            else
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";

            }

        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
        }

        return returnValueElement.OuterXml;
    }

}
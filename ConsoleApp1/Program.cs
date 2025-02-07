using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string publicKey = "PFJTQUtleVZhbHVlPjxNb2R1bHVzPitmQ0x2elNBNUNidHo4UlJuMllnN2VhaVIvZVhZbVRVbzJGMzZtVVZyckI2KzBLc2ZqVS9VNFBMLzVFOU1KSTcwK2JsaThsbFRzVzNLQ09CeEhHdzJCdGZZTUo2YURHcXhMZzFBem81ZXFzc0hTVldwaU1JclFraXpZVUJ5b1FJbkF6ZWxNY09ISnJXZlBYOHJmeEJyTndTc2VRUHp0aStCWjhQeEtPTlVsVT08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
            Auth.Authentication auth = new Auth.Authentication();
            auth.Url = "http://localhost/UOF_Speedy"+"/PublicAPI/System/Authentication.asmx";

            string token = auth.GetToken("ERP",
                RSAEncrypt(publicKey,"admin"),
                RSAEncrypt(publicKey,"123456"));

          //  Console.WriteLine(token);

            string result = "";

            string formInfo = GetFormInfo();
            Console.WriteLine(formInfo);
            WKF.Wkf wkf = new WKF.Wkf();
            result = wkf.SendForm(token, formInfo);

            Console.WriteLine(result);

        }

        private static string GetFormInfo()
        {
            Console.WriteLine("請輸入類別type");
            string type = Console.ReadLine();
            Console.WriteLine("請輸入品項item");
            string item = Console.ReadLine();
            Console.WriteLine("請輸入金額amount");
            string amount = Console.ReadLine();

            XElement formXE = new XElement("Form", new XAttribute("formVersionId", "6fd8fa9c-ecc2-41b3-8315-7c77d9e9e676"), new XAttribute("urgentLevel", "2"));
            XElement applicantXE = new XElement("Applicant", new XAttribute("account", "Tony")
                , new XAttribute("groupId", ""), new XAttribute("jobTitleId", ""));

            XElement commentXE = new XElement("Comment", "This is a comment");

            XElement formFieldValueXE = new XElement("FormFieldValue");

            XElement fieldItemNoXE = new XElement("FieldItem", new XAttribute("fieldId", "NO")
                , new XAttribute("fieldValue", "")
                , new XAttribute("IsNeedAutoNbr", "false"));

            XElement fieldItemTypeXE = new XElement("FieldItem", new XAttribute("fieldId", "type")
                , new XAttribute("fieldValue", type));

            XElement fieldItemITemXE = new XElement("FieldItem", new XAttribute("fieldId", "item")
                , new XAttribute("fieldValue", item));

            XElement fieldItemAmountXE = new XElement("FieldItem", new XAttribute("fieldId", "amount")
              , new XAttribute("fieldValue", amount));

            formXE.Add(applicantXE);
            formXE.Add(formFieldValueXE);

            applicantXE.Add(commentXE);

            formFieldValueXE.Add(fieldItemNoXE, fieldItemTypeXE, fieldItemITemXE, fieldItemAmountXE);
            return formXE.ToString();
        }

        /// <summary>
        /// RSA 加密
        /// </summary>
        /// <param name="privateKey"></param>
        /// <param name="crTexturlparam>
        /// <returns></returns>
        private static string RSAEncrypt(string publicKey, string crText)
        {

            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();

            byte[] base64PublicKey = Convert.FromBase64String(publicKey);
            rsa.FromXmlString(System.Text.Encoding.UTF8.GetString(base64PublicKey));


            byte[] ctTextArray = Encoding.UTF8.GetBytes(crText);


            byte[] decodeBs = rsa.Encrypt(ctTextArray, false);

            return Convert.ToBase64String(decodeBs);
        }
    }
}

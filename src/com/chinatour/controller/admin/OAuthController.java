/*package com.chinatour.controller.admin;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinatour.Constant;
import com.chinatour.webService.OAuthInfoProvider;
import com.chinatour.webService.impl.OAuthInfoProviderImpl;
import com.intuit.ia.connection.IAPlatformClient;
import com.intuit.ia.exception.OAuthException;
import com.intuit.ipp.exception.FMSException;

@Controller
@RequestMapping("/admin/oauth")
public class OAuthController {
	@Resource(name = "oAuthInfoProviderImpl")
    private OAuthInfoProvider oAuthInfoProvider = new OAuthInfoProviderImpl();

    @RequestMapping(value = "/request_token", method = RequestMethod.GET)
    public void requestOAuthToken(final HttpServletResponse response,
                                  @RequestParam(value = "companyId", required = true) String companyId) throws IOException, FMSException {

        //Instantiate the QuickBook SDK's IAPlatformClient object
        IAPlatformClient client = new IAPlatformClient();
        try {
             Use the IAPlatformClient to get a Request Token 
               and Request Token Secret from Intuit 
        	
            final Map<String, String> requestTokenAndSecret =   
              client.getRequestTokenAndSecret(Constant.OAUTHCONSUMERKEY,Constant.OAUTHCONSUMERSECRET);

            //Pull the values out of the map
            final String requestToken = requestTokenAndSecret.get("requestToken");
            final String requestTokenSecret = requestTokenAndSecret.get("requestTokenSecret");

             Persist the request token and request token secret in the app database         
             * on the given company, we will need the Request Token Secret to make the  
             * final request to Intuit for the Access Tokens 
             
            oAuthInfoProvider.setRequestTokenValuesForCompany(companyId, requestToken, requestTokenSecret);

            // Retrieve the Authorize URL
            final String authURL = client.getOauthAuthorizeUrl(requestToken);

            // Redirect to the authorized URL page   应该进入的异常是OAuthException  
            response.sendRedirect(authURL);
            	
        } catch (OAuthException e) {
            throw new RuntimeException(e);
        }
    }

    @RequestMapping(value = "/request_token_ready", method = RequestMethod.GET)
    public void requestTokenReady(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        IAPlatformClient client = new IAPlatformClient();
        final String verifierCode = request.getParameter("oauth_verifier");
        final String realmID = request.getParameter("realmId");
        final String requestToken = request.getParameter("oauth_token");

        final com.chinatour.entity.CompanyRequestTokenSecret companyRequestTokenSecret = oAuthInfoProvider.getCompanyRequestTokenSecret(requestToken);

        try {
            final Map<String, String> oAuthAccessToken = client.getOAuthAccessToken(verifierCode, requestToken, companyRequestTokenSecret.getRequestTokenSecret(),
                    Constant.OAUTHCONSUMERKEY, Constant.OAUTHCONSUMERSECRET);

            final String accessToken = oAuthAccessToken.get("accessToken");
            final String accessTokenSecret = oAuthAccessToken.get("accessTokenSecret");

            oAuthInfoProvider.setAccessTokenForCompany(companyRequestTokenSecret.getAppCompanyId(), realmID,
                    accessToken, accessTokenSecret);
            response.sendRedirect(getProtocolHostnameAndPort(request) + "/chinatour-3.0/close.html");

        } catch (OAuthException e) {
            throw new RuntimeException(e);
        }

    }

    public static String getProtocolHostnameAndPort(final HttpServletRequest request) {
        String protocol = request.getProtocol().split("/")[0].toLowerCase();
        String hostname = request.getServerName();
        int port = request.getServerPort();

        StringBuilder result = new StringBuilder(protocol + "://" + hostname);
        if (port != 80) {
            result.append(":").append(port);
        }

        return result.toString();
    }
}
*/
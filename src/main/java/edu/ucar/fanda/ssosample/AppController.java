package edu.ucar.fanda.ssosample;

import org.opensaml.saml2.core.Attribute;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.saml.SAMLCredential;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class AppController {
	@RequestMapping("/home")
	public String hello(Model model) {
		model.addAttribute("message", "Welcome to the unsecured section of SSOSAMPLE!");
		return "home";
	}
	@RequestMapping("/secured")
	public String authConfirm(Model model) {
		model.addAttribute("message", "Successful authentication using SAML!");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		SAMLCredential credential = (SAMLCredential) authentication.getCredentials();
		model.addAttribute("username", authentication.getName());
		model.addAttribute("authprincipal", authentication.getPrincipal());
		model.addAttribute("crednameidvalue", credential.getNameID().getValue());
		model.addAttribute("crednameidformat", credential.getNameID().getFormat());
		model.addAttribute("credauthissuerval", credential.getAuthenticationAssertion().getIssuer().getValue());
		model.addAttribute("credauthissueinstant", credential.getAuthenticationAssertion().getIssueInstant());

		return "secured";
	}
}

package com.paftp.dbtools;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.paftp.bean.*;

public class ResultParser {

	public Testpass getTestpass(String path) {
		Testpass testpass = new Testpass();
		Properties p = this.getProperties(path + "\\testpass.properties");
		testpass.setSut(p.getProperty("sut"));
		testpass.setTestset(p.getProperty("testset"));
		testpass.setVersion(p.getProperty("version"));
		File[] files = this.getFiles(path + "\\result\\");
		List<Testsuite> testsuites = new ArrayList<Testsuite>();
		for (int i = 0; i < files.length; i++) {
			Testsuite testsuite = this.getTestsuite(path + "\\result\\"
					+ files[i].getName());
			testsuites.add(testsuite);
		}
		testpass.setTestsuites(testsuites);
		return testpass;
	}

	public Testsuite getTestsuite(String path) {
		Testsuite testsuite = new Testsuite();
		String testsuitename = this.getFileName(path);
		testsuite.setSuitename(testsuitename);
		Document xmlDoc = this.getXmlFile(path);
		Element root = xmlDoc.getDocumentElement();
		NodeList list = root.getChildNodes();
		List<Testcase> testcases = new ArrayList<Testcase>();
		for (int i = 0; i < list.getLength(); i++) {
			if (list.item(i) instanceof Element) {
				Element testcaseNode = (Element) list.item(i);
				Testcase testcase = this.getTestcase(testcaseNode);
				testcases.add(testcase);
			}
		}
		testsuite.setTestcases(testcases);
		return testsuite;
	}

	public Testcase getTestcase(Element testcaseElement) {
		Testcase testcase = new Testcase();
		testcase.setCasename(testcaseElement.getAttribute("name"));
		testcase.setResult(testcaseElement.getAttribute("result"));

		NodeList list = testcaseElement.getChildNodes();
		List<Testcasecontent> testcasecontents = new ArrayList<Testcasecontent>();
		for (int i = 0; i < list.getLength(); i++) {
			if (list.item(i) instanceof Element) {
				Element testcasecontentNode = (Element) list.item(i);
				Testcasecontent testcasecontent = this
						.getTestcasecontent(testcasecontentNode);
				testcasecontents.add(testcasecontent);
			}
		}
		testcase.setTestcasecontents(testcasecontents);

		return testcase;
	}

	public Testcasecontent getTestcasecontent(Element testcasecontentElemet) {
		Testcasecontent testcasecontent = new Testcasecontent();
		if (testcasecontentElemet.getNodeName().equals("Comment")) {
			testcasecontent.setType("Comment");
		} else if (testcasecontentElemet.getNodeName().equals("Checkpoint")) {
			testcasecontent.setType("Checkpoint");
			testcasecontent.setResult(testcasecontentElemet.getAttribute("result"));
		} else {
			testcasecontent.setType(testcasecontentElemet.getNodeName());
		}
		testcasecontent.setValue(testcasecontentElemet.getTextContent());
		return testcasecontent;
	}

	private Document getXmlFile(String path) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = null;
		Document xmlDoc = null;

		try {
			db = factory.newDocumentBuilder();

		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			xmlDoc = (Document) db.parse(new File(path));
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xmlDoc;
	}

	private Properties getProperties(String path) {
		InputStream in = null;
		Properties p = new Properties();
		try {
			in = new BufferedInputStream(new FileInputStream(path));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			p.load(in);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}

	private String getFileName(String path) {
		File file = new File(path);
		String name = file.getName();
		return name;
	}

	private File[] getFiles(String path) {
		File file = new File(path);
		// get the folder list
		File[] files = file.listFiles();
		return files;
	}
}

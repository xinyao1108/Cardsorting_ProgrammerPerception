import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

@SuppressWarnings("serial")
@WebServlet(name = "ProgressUpdate", urlPatterns = {"/ProgressUpdate"})
public class ProgressUpdate extends HttpServlet {

	String homPath = "";
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
				
                HttpSession session = request.getSession(true);
                
                try{
                    int sis = (int) session.getAttribute("SIS");
                    String statusType = request.getParameter("StatusType");;
                    int status = Integer.parseInt(request.getParameter("Status"));
                    int receivedID = (int) session.getAttribute("ReceivedID");

                    if (statusType.equals("Instructions1")){
                        if (sis == 1 && status == 1 && receivedID == 1){
                            session.setAttribute("Instructions1",1);
                            response.sendRedirect("Main.jsp");
                        }else{
                            response.sendRedirect("index.html");
                        }
                    }else{
                        response.sendRedirect("index.html");
                    }
                }catch(Exception e){
                	Logger logger = Logger.getLogger(this.getClass().getName());
                    logger.log(Level.WARNING, e.getMessage());
                	
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("An error has occured.");
                    e.printStackTrace(writer);
                    writer.close();
                }
    }
	
}
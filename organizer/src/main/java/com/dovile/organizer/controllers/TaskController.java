package com.dovile.organizer.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dovile.organizer.entities.Task;
import com.dovile.organizer.entities.User;
import com.dovile.organizer.repository.TaskRepository;
import com.dovile.organizer.repository.UserRepository;
import com.dovile.organizer.util.CheckTime;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

@Controller
@RequestMapping("/task")
public class TaskController {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private TaskRepository taskRepository;


	@RequestMapping(path = "edit", method = RequestMethod.GET)
	public ModelAndView editTask(@RequestParam(name = "id", required = false) String id,
			@RequestParam(name = "tid", required = false) String tid, @RequestParam (name = "dateYour", required = false) String dateYour, Model modelMap) {

		Task t = null;

		try {
			t = taskRepository.getOne(new Integer(tid));
		} catch (Exception ex) {
			// to do
		}

		User u = null;
		List<Task> tasksByID;
		// Check if task  is not null we get user, otherwise we get it from id
		if (t != null) {
			u = t.getUser();
			try {
				tasksByID = taskRepository.findUserID(new Integer(id));
			} catch (Exception ex) {
				return new ModelAndView("redirect:../login");
			}
			
		} else {
			t = new Task();
			// If task is null we get user id:
			try {
				u = userRepository.getOne(new Integer(id));
				tasksByID = taskRepository.findUserID(new Integer(id));
			} catch (Exception ex) {
				return new ModelAndView("redirect:../login");
			}
		}	
		
		ModelAndView mv = new ModelAndView("editTask");
		mv.addObject("user", u);
		mv.addObject("task", t);
		mv.addObject("tasksByID", tasksByID);
		
		try {
			modelMap.addAttribute("dateYour", dateYour);
		} catch (Exception e) {
			SimpleDateFormat ft1 = new SimpleDateFormat("yyyy-MM-dd");
			modelMap.addAttribute("dateYour", ft1.format(new Date()));
		}
		
		
		return mv;
	}

	// save method
	@RequestMapping(path = "save", method = RequestMethod.POST)
	@Transactional
	public String saveTask(@RequestParam(name = "id", required = false) String id,
			@RequestParam(name = "tid", required = false) String tid,
			@RequestParam(name = "name", required = false) String name,
			@RequestParam(name = "description", required = false) String description,
			@RequestParam(name = "date", required = false) String date,
			@RequestParam(name = "shour", required = false) String shour,
			@RequestParam(name = "smin", required = false) String smin,
			@RequestParam(name = "fhour", required = false) String fhour,
			@RequestParam(name = "fmin", required = false) String fmin, ModelMap modelMap, final RedirectAttributes redirectAttributes) {

		Task t = null;
		//check if id and is exist
		try {
			t = taskRepository.getOne(new Integer(tid));
		} catch (Exception ex) {

		}

		if (t == null) {
			t = new Task();
		}

		if (t.getUser() == null) {
			try {
				User u = userRepository.getOne(new Integer(id));
				t.setUser(u);
			} catch (Exception e) {

			}
		}
		if (t.getUser() == null) {
			return "redirect:../";
		}
		if (name != null) {
			t.setName(name);
		} else {
			t.setName("empty");
		}
		if (description != null) {
			t.setDescription(description);
		} else {
			t.setDescription("empty");
		}
		
		
		
		//filter by date and user id
		List<Task> taskRez = taskRepository.findUserIDAndDate(new Integer(id), date);
		modelMap.addAttribute("taskRez", taskRez);
		
		

		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		try {
			boolean checkTime=true;
			Date sDate = ft.parse(date + " " + shour + ":" + smin);
			Date fDate = ft.parse(date + " " + fhour + ":" + fmin);
			
			List<Task> taskListByDate;
			if (t.getId() != null) {
				taskListByDate = taskRepository.findUserIDNotID(new Integer(id), new Integer(tid));
			} else {
				taskListByDate = taskRepository.findUserID(new Integer(id));
			}

			for (int i = 0; i < taskListByDate.size(); i++) {

				Date start = taskListByDate.get(i).getStart_date();
				Date finish = taskListByDate.get(i).getFinish_date();
				checkTime = CheckTime.reservationTime(start, finish, sDate, fDate);
				
				if (checkTime == false) {
					 redirectAttributes.addFlashAttribute("msg", "This time has been reserved. Please choose other time!");
					 redirectAttributes.addFlashAttribute("newDate", sDate);
					
					if (t.getId() != null) {
						return "redirect:./edit?id=" + t.getUser().getId() + "&&tid=" + t.getId()+"&&dateYour="+date;
					} else {
						return "redirect:./edit?id=" + t.getUser().getId()+"&&dateYour="+date;
					}
				}
			}
			

			
			t.setStart_date(sDate);
			t.setFinish_date(fDate);
		} catch (Exception e) {
			t.setStart_date(new Date());
			t.setFinish_date(new Date());
		}

		
		taskRepository.save(t);

		return "redirect:../tasks?filter="+date;
	}
	
	
//Delete request
	@RequestMapping(path = "delete", method = RequestMethod.GET)
	@Transactional
	public String delete(@RequestParam(name = "tid") String tid) {
		Integer id = null;
		String date=null;
		SimpleDateFormat ft1 = new SimpleDateFormat("yyyy-MM-dd");

		try {

			Task t = taskRepository.getOne(new Integer(tid));
			date=ft1.format(t.getStart_date());
			id = t.getUser().getId();
			
			taskRepository.delete(t);
		} catch (Exception ex) {

		}
		if (id == null) {

			return "redirect:./login";
		}

		
		
		// Redirecting to list of products for specified by shop
		return "redirect:../tasks?filter="+date;
	}
}

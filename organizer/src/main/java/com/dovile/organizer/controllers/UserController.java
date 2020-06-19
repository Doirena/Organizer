package com.dovile.organizer.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dovile.organizer.dto.TaskData;
import com.dovile.organizer.entities.Task;
import com.dovile.organizer.entities.User;
import com.dovile.organizer.repository.TaskRepository;
import com.dovile.organizer.repository.UserRepository;
import com.dovile.organizer.service.SecurityService;
import com.dovile.organizer.service.UserService;
import com.dovile.organizer.util.TimeDuration;
import com.dovile.organizer.validator.UserValidator;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	@Autowired
	private SecurityService securityService;

	@Autowired
	private UserValidator userValidator;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private TaskRepository taskRepository;

	//request for registration page
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public String registration(Model model) {
		model.addAttribute("userForm", new User());

		return "registration";
	}
	//request for registration for new user body
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
		userValidator.validate(userForm, bindingResult);

		if (bindingResult.hasErrors()) {
			return "registration";
		}

		userService.save(userForm);

		securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

		return "redirect:/tasks";
	}

	//request for login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model, String error, String logout) {
		if (error != null)
			model.addAttribute("error", "Your username and password is invalid.");

		if (logout != null)
			model.addAttribute("message", "You have been logged out successfully.");

		return "login";
	}

	// request for tasks
	@RequestMapping(value = { "/", "/tasks" }, method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView currentUserNameSimple(HttpServletRequest request, @RequestParam (name = "filter", required = false) String filter, Model modelMap) {
		Principal principal = request.getUserPrincipal();
		List<User> users = userRepository.findAll();
		ModelAndView mv = new ModelAndView("tasks");
		User user=null;
		
		for (int i = 0; i < users.size(); i++) {

			if (principal.getName().equals(users.get(i).getUsername())) {
				 user = users.get(i);
				mv.addObject("user", user);
				break;
			}

		}
		List<Task> task = taskRepository.findUserID(user.getId());
		SimpleDateFormat ft1 = new SimpleDateFormat("yyyy-MM-dd");
		String compareDate;
		if (filter !=null) {
			compareDate=filter;
		} else {
			compareDate=ft1.format(new Date());
		}
		
		modelMap.addAttribute("yourDate", compareDate);
		List<TaskData> taskList = new ArrayList<TaskData>();
		for (int i = 0; i < task.size(); i++) {
			if(compareDate.equals(ft1.format(task.get(i).getStart_date()))) {
			TaskData taskData = new TaskData();
			taskData.setId(task.get(i).getId());
			taskData.setName(task.get(i).getName());
			try {
				taskData.setDate(task.get(i).getStart_date());
			} catch (Exception e) {
				taskData.setDate(null);
			}
			try {
				taskData.setStart_time(task.get(i).getStart_date());
			} catch (Exception e) {
				taskData.setStart_time(null);
			}

			taskData.setFinish_time(task.get(i).getFinish_date());
			taskData.setDescription(task.get(i).getDescription());
			//Check if times is bad or some mistake show null(empty)
			try {
				taskData.setDuration(TimeDuration.durationTime(taskData.getFinish_time(), taskData.getStart_time()));
			} catch (Exception e) {
				taskData.setDuration(null);
			}
			modelMap.addAttribute("emptyTask", task.get(i).getStart_date());
			taskList.add(taskData);
			}
		}
		
		mv.addObject("tasks",taskList);

		return mv;

	}

}

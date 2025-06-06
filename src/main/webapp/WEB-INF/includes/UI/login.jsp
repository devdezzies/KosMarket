<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="flex flex-col justify-center min-h-screen py-12 px-4 sm:px-6">
  <div class="sm:mx-auto sm:w-full sm:max-w-sm">
    <h1 class="mx-auto text-center text-5xl">👋️</h1>
    <h2 class="mt-5 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Hi, Welcome Back!</h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <span class="block sm:inline"><%= request.getAttribute("errorMessage") %></span>
      </div>
    <% } %>
    <form class="space-y-6" action="${pageContext.request.contextPath}/authentication?menu=check" method="POST">
      <div>
        <label for="email" class="block text-sm font-medium leading-6 text-gray-900">Email address</label>
        <div class="mt-2">
          <input type="email" name="email" id="email" autocomplete="email" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6">
        </div>
      </div>

      <div>
        <div class="flex items-center justify-between">
          <label for="password" class="block text-sm/6 font-medium text-gray-900">Password</label>
          <div class="text-sm">
            <a href="#" class="font-semibold text-indigo-600 hover:text-indigo-500">Forgot password?</a>
          </div>
        </div>
        <div class="mt-2">
          <input type="password" name="password" id="password" autocomplete="current-password" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6">
        </div>
      </div>

      <div>
        <button type="submit" class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Sign in</button>
      </div>
    </form>

    <p class="mt-10 text-center text-sm/6 text-gray-500">
      Not a member?
      <a href="?page=registration" class="font-semibold text-indigo-600 hover:text-indigo-500">Create an Account</a>
    </p>
  </div>
</div>

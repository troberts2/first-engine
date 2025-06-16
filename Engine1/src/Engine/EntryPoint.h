#pragma once

#ifdef ENGINE_PLATFORM_WINDOWS

extern Engine::Application* Engine::CreateApplication(); 

int main(int argc, char**)
{
	Engine::Log::Init();
	EG_CORE_WARN("Engine logger started.");
	EG_INFO("App logger started.");

	auto app = Engine::CreateApplication();
	printf("Engine started");
	app->Run();
	
	delete app;
}

#endif

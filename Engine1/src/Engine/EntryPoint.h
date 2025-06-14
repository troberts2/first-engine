#pragma once

#ifdef ENGINE_PLATFORM_WINDOWS

extern Engine::Application* Engine::CreateApplication(); 

int main(int argc, char**)
{
	auto app = Engine::CreateApplication();
	printf("Engine started");
	app->Run();
	
	delete app;
}

#endif

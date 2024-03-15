from vllm import LLM, SamplingParams

prompts = ["Please create a story about Hornet, a warrior from the deepnest.", "Please create an interaction between a witch and a dragon in the settings of Final Fantasy X.", "One Punch Man, the critically acclaimed and globally adored Shoen superhero anime series, is finally getting a lore-accurate world to explore with the upcoming launch of One Punch Man: World on iOS, Android, and PC. Please review this game.", "What is the trope for the following example? Example: AdventureQuest and DragonFable feature eight elements in general: Earth/Nature, Fire, Wind, Water, Energy, Ice, Light, and Darkness. DragonFable's main storyline also revolves around eight elemental orbs, each one with one of those respective elements. It also throws in a ninth element, called Void, which is drawn from a magical realm of the same name."]  # Sample prompts.

sampling_params = SamplingParams(temperature=1, top_p=0.95,max_tokens=500)
llm = LLM(model="mistralai/Mistral-7B-Instruct-v0.1",dtype='half')  # Create an LLM.
outputs = llm.generate(prompts, sampling_params)
# Print the outputs.
for output in outputs:
    prompt = output.prompt
    generated_text = output.outputs[0].text
    print(f"Prompt: {prompt},\n Generated text: {generated_text}")
    print("\n\n")

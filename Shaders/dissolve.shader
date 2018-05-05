shader_type canvas_item;
render_mode unshaded;

uniform vec4 override_colour : hint_color;
uniform bool use_override;

uniform sampler2D noise_texture;

uniform vec4 burn_highlight_colour : hint_color;
uniform vec4 burn_colour : hint_color;
uniform vec4 burnt_colour : hint_color;

uniform float dissolve_precentage : hint_range(0, 1);
uniform float burn_highlight_width : hint_range(0, 1);
uniform float burn_width : hint_range(0, 1);
uniform float burnt_width : hint_range(0, 1);

void fragment()
{
	vec4 out_colour = vec4(1.0, 1.0, 1.0, 1.0);
	vec4 noise = texture(noise_texture, UV);
	
	float progress = max(0.0, dissolve_precentage-noise.r);
	
	out_colour = texture(TEXTURE, UV);
	
	if(use_override)
	{
		out_colour.rgb = override_colour.rgb;
	}
	
	if(progress > 0.0 && progress < burnt_width)
	{
		float t = progress / burnt_width;
		out_colour.rgb = mix(out_colour.rgb, burnt_colour.rgb, t);
	}else if(progress >= burnt_width && progress < burnt_width+burn_width){
		float t = (progress-burnt_width) / burn_width;
		out_colour.rgb = burn_colour.rgb;
	}else if(progress >= burn_width+burnt_width && progress < burnt_width+burn_width+burn_highlight_width)
	{
		float t = (progress-burnt_width-burn_width) / burn_highlight_width;
		out_colour.rgb = burn_highlight_colour.rgb;
		out_colour.a = 1.0-t;
	}else if(progress >= burnt_width+burn_width+burn_highlight_width){
		out_colour.a = 0.0;
	}
	
	COLOR = out_colour;
}
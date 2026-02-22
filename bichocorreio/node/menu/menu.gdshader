shader_type canvas_item;

uniform vec2 resolution = vec2(1920.0, 1080.0);
uniform vec3 color: source_color;
uniform vec3 replace_black_color : source_color;
uniform float speed: hint_range(0.0, 10.0, 0.01);
uniform float pixelation : hint_range(50.0, 800.0, 1.0);
uniform float black_threshold: hint_range(0.0, 0.2, 0.001);

void fragment() {
	vec2 uv = UV;
	uv = floor(uv * pixelation) / pixelation;
	uv -= 0.5;
	uv.x *= resolution.x / resolution.y;
	float time = TIME * speed;
	float radius = length(uv);
	float theta = atan(uv.x, uv.y);
	float dis = time + 20.0 * exp(-radius);
	float shift = sin(time + 7.0 * theta + dis);
	float shape = sin(shift + dis);
	
	vec3 result = color * shape / radius * 0.4;
	
	float intensity = length(result);
	if (intensity < black_threshold) {
		result = replace_black_color;
	}
	
	COLOR = vec4(result, 1.0);
}

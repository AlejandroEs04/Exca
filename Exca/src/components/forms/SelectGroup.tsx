import { ChangeEvent } from "react"

type Option = {
    label: string
    value: string | number
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    placeholder: string
    label: string
    options?: Option[]
    disable?: boolean
    onChangeFnc: (e: ChangeEvent<HTMLSelectElement>) => void
}

export default function SelectGroup({ 
    name, 
    id = name, 
    value, 
    placeholder,
    label,
    onChangeFnc, 
    options = [],
    disable = false
} : InputGroupProps) {
    return (
        <div className="input-group">
            <label htmlFor={id}>{label}</label>
            <select disabled={disable} value={value} onChange={onChangeFnc} name={name} id={id}>
                <option value="">{placeholder}</option>
                {options.map((option, index) => (
                    <option key={index} value={option.value}>
                        {option.label}
                    </option>
                ))}
            </select>
        </div>
    )
}
